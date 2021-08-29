AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.PrintName = "Alcoholic"
ENT.Category = "Overlord Community"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.AutomaticFrameAdvance = true

local function GetFinalPrice(quality)
	return 2 * quality
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/Humans/Group02/Male_04.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:SetSequence("Lookoutidle")
		self:ResetSequenceInfo()
	end

	function ENT:Use(act)
		self:SetUseType(SIMPLE_USE)
		local char = act:GetCharacter()
		local inv = char:GetInventory()

		local moonshine = inv:HasItem("moonshine")

		if moonshine then
			local money = char:GetMoney()
			local finalPrice = GetFinalPrice(moonshine:GetData("quality", 0))
			char:SetMoney(money + finalPrice)
			moonshine:Remove()
			act:Notify("You have received " .. finalPrice .. " tokens")
		else
			act:Notify("Oi mate! Feck off, you haven't got me moonshine!")
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end

function ENT:Think()
	self:NextThink(CurTime())
	return true
end
