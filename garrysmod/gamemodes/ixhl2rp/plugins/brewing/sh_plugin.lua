local PLUGIN = PLUGIN;

PLUGIN.name = "Brewing";


PLUGIN.StateResults = {
  ["Idle"] = "The barrel seems to be empty",
  ["Brewing"] = "There are liquids in this barrel, they seem to be brewing",
  ["Finished"] = "There are liquids in this barrel, they seem ready to harvest"
};

PLUGIN.IngWater = {"breenwater", "breensparklingwaters", "breenspecialwater"};
PLUGIN.IngAcl = {"gin", "whiskey", "vodka"};

PLUGIN.IngCombinations = {
  ["ginwater"] = function() return math.random(5, 25) end,
  ["ginsparklingwater"] = function() return math.random(15, 30) end,
  ["ginspecialwater"] = function() return math.random(25, 35) end,
  ["vodkawater"] = function() return math.random(20, 45) end,
  ["vodkasparklingwater"] = function() return math.random(30, 50) end,
  ["vodkaspecialwater"] = function() return math.random(40, 55) end,
  ["whiskeywater"] = function() return math.random(60, 75) end,
  ["whiskeysparklingwater"] = function() return math.random(70, 80) end,
  ["whiskeyspecialwater"] = function() return math.random(80, 90) end
};

if CLIENT then
  function PLUGIN:PopulateEntityInfo(ent, tool)
    if ent:GetClass() == "ix_brewbarrel" then
      local name = tool:AddRow("Name");
      name:SetText("A Brewing Barrel");
      name:SetBackgroundColor(Color(0, 110, 230));
      name:SetImportant();
      name:SizeToContents();

      local status = tool:AddRowAfter("Name", "Status");
      status:SetText(self.StateResults[ent:GetStatus()]);
      status:SetBackgroundColor(Color(0, 110, 230));
      status:SizeToContents();
    end;
  end;

  local function ClientHasItem(item) -- I hate that HasItem is serverside
    local char = LocalPlayer():GetCharacter();
    local inv = char:GetInventory().slots;

    for i, v in pairs(inv) do
      for i2, v2 in pairs(v) do
        if v2.name == item then
          return true;
        end;
      end;
    end;
  end;

  net.Receive("ixBrewingMenu", function()
    local ent = net.ReadEntity();

    local menu = DermaMenu();

    for i, v in ipairs({"Gin", "Vodka", "Whiskey"}) do
      local subMenu = menu:AddSubMenu(v);

      for i2, v2 in ipairs({"Water", "Sparkling Water", "Special Water"}) do
        local option = subMenu:AddOption(v2, function()
          net.Start("ixBrewingBrew");
            net.WriteString(v);
            net.WriteString(v2);
            net.WriteEntity(ent);
          net.SendToServer();
        end);
        if ClientHasItem("Breen's " .. v2) and ClientHasItem(v) then
          option.Paint = function(pan, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 255, 0, 100));
          end;
        else
          option.Paint = function(pan, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0, 100));
          end;
        end;
      end;
    end;
    menu:Open(ScrW()/2, ScrH()/2);
  end);
end;


if SERVER then

  util.AddNetworkString("ixBrewingBrew");
  util.AddNetworkString("ixBrewingMenu");


  function PLUGIN:SaveData()
    local data = {}
    for i, v in ipairs(ents.FindByClass("ix_alcoholic")) do
      data[#data + 1] = {
        v:GetPos(),
        v:GetAngles()
      };
    end;

    ix.data.Set("brewingalcoholics", data);
  end;


  function PLUGIN:LoadData()
    data = ix.data.Get("brewingalcoholics") or {};

    for i, v in ipairs(data) do
      local alc = ents.Create("ix_alcoholic");
      alc:SetPos(v[1]);
      alc:SetAngles(v[2]);
      alc:Spawn();
    end;
  end;


  local function FixNames(string)
    local stringTable = string.ToTable(string);

    for i, v in ipairs(stringTable) do
      if v == " " then table.remove(stringTable, i) end;
    end;

    stringTable = table.concat(stringTable, "");
    return string.lower(stringTable);
  end;

  net.Receive("ixBrewingBrew", function(_, ply)
    local char = ply:GetCharacter();
    local inv = char:GetInventory();

    local ingAlc = net.ReadString();
    local ingLiq = net.ReadString();
    local ent = net.ReadEntity();

    ingAlc = FixNames(ingAlc);
    ingLiq = FixNames(ingLiq);

    local itemAlc = inv:HasItem(ingAlc);
    local itemLiq = inv:HasItem(ingLiq);

    if !itemAlc or !itemLiq then
      ply:Notify("You do not have the items for this");
      return;
    end;

    local combo = (ingAlc .. ingLiq);

    ply:SetAction("Adding ingredients...", 3);
    ply:DoStaredAction(ent,
    function()
      ent:SetCombo(combo);
      ent:SetStatus("Brewing");
      ent:EmitSound("ambient/water/underwater.wav", 75, 100);
      itemAlc:Remove();
      itemLiq:Remove();
      timer.Simple(math.random(300, 600), function() -- 5 to 10 mins
        ent:SetStatus("Finished");
        ent:StopSound("ambient/water/underwater.wav");
      end);
    end, 3,
    function()
      ply:SetAction();
    end);
  end);
end;
