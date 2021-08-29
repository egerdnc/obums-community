AddCSLuaFile()

local PLUGIN = PLUGIN;

ENT.Base = "base_entity";
ENT.Type = "anim";
ENT.PrintName = "Brewing Barrel";
ENT.Category = "Helix";
ENT.Spawnable = true;
ENT.RenderGroup = RENDERGROUP_BOTH;

local comboRisk = {
  ["ginwater"] = 0,
  ["ginsparklingwater"] = 2,
  ["ginspecialwater"] = 4,
  ["vodkawater"] = 6,
  ["vodkasparklingwater"] = 8,
  ["vodkaspecialwater"] = 10,
  ["whiskeywater"] = 15,
  ["whiskeysparklingwater"] = 20,
  ["whiskeyspecialwater"] = 30
};

if SERVER then
  function ENT:Initialize()
    self:SetModel("models/props_c17/oildrum001.mdl");
    self:SetSolid(SOLID_VPHYSICS);
    self:PhysicsInit(SOLID_VPHYSICS);

    local physObj = self:GetPhysicsObject()

    if (IsValid(physObj)) then
      physObj:EnableMotion(true);
      physObj:Wake();
    end;

    print(physObj:IsMoveable());

    self:SetStatus("Idle");
  end;

  local callbacks = {
    ["Idle"] = function(ent, ply)
      net.Start("ixBrewingMenu");
        net.WriteEntity(ent);
      net.Send(ply);
    end,
    ["Brewing"] = function(ent, ply)
      ply:Notify("This barrel is still brewing, please wait");
    end,
    ["Finished"] = function(ent, ply)
      local inv = ply:GetCharacter():GetInventory();
      local combo = ent:GetCombo();

      if !PLUGIN.IngCombinations[combo] then return end;

      if math.random(1, 100) <= comboRisk[combo] then -- This should work?
        ent:EmitSound("weapons/explode5.wav");
        ent:Remove();
        ply:TakeDamage(35);
      else
        inv:Add("moonshine", 1, {quality = PLUGIN.IngCombinations[combo]()});
        ply:Notify("You have collected the moonshine");
        ent:SetStatus("Idle");
        ent:SetCombo("");
      end;
    end;
  };

  function ENT:Use(act)
    self:SetUseType(SIMPLE_USE);
    local bSucceed, result = pcall(callbacks[self:GetStatus()], self, act);
    if !bSucceed then
      ErrorNoHalt("Warning callback for " .. self:GetStatus() .. " has failed\n " .. result);
    end;
  end;
end;


function ENT:SetupDataTables()
  self:NetworkVar("String", 0, "Status");
  self:NetworkVar("String", 1, "Combo");
end;

function ENT:OnRemove()
  self:StopSound("ambient/water/underwater.wav");
end;


if CLIENT then
  function ENT:Draw()
    self:DrawModel();
  end;
end;
