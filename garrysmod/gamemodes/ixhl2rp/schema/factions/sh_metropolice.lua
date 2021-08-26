
FACTION.name = "Civil Protection"
FACTION.description = "Civil Protection units employed by an unkown larger group know as MPF."
FACTION.color = Color(50, 100, 150)
FACTION.pay = 10
FACTION.models = {"models/dpfilms/metropolice/hdpolice.mdl"}
FACTION.weapons = {"ix_stunstick"}
FACTION.isDefault = false
FACTION.runSounds = {[0] = "NPC_MetroPolice.RunFootstepLeft", [1] = "NPC_MetroPolice.RunFootstepRight"}

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()
	
	inventory:Add("flashlight", 1)
	inventory:Add("stunstick", 1)
end

function FACTION:GetDefaultName(client)
	return "C2.i4-" .. Schema:ZeroNumber(math.random(1, 9999), 4), true
end

function FACTION:OnTransfered(client)
	local character = client:GetCharacter()

	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
end

function FACTION:OnNameChanged(client, oldValue, value)
	local character = client:GetCharacter()

	if (!Schema:IsCombineRank(oldValue, "i4") and Schema:IsCombineRank(value, "i4")) then
		character:JoinClass(CLASS_I4)
	elseif (!Schema:IsCombineRank(oldValue, "i3") and Schema:IsCombineRank(value, "i3")) then
		character:JoinClass(CLASS_I3)
	elseif (!Schema:IsCombineRank(oldValue, "i2") and Schema:IsCombineRank(value, "i2")) then
		character:JoinClass(CLASS_I3)
	elseif (!Schema:IsCombineRank(oldValue, "i1") and Schema:IsCombineRank(value, "i1")) then
		character:JoinClass(CLASS_I3)
	elseif (!Schema:IsCombineRank(oldValue, "OfC") and Schema:IsCombineRank(value, "OfC")) then
		
	elseif (!Schema:IsCombineRank(oldValue, "SqL") and Schema:IsCombineRank(value, "SqL")) then
		character:JoinClass(CLASS_EMP)

		character:SetModel("models/leet_police2.mdl")
	elseif (!Schema:IsCombineRank(oldValue, "DvL") and Schema:IsCombineRank(value, "DvL")) then
		character:SetModel("models/eliteshockcp.mdl")
	end

	if (!Schema:IsCombineRank(oldValue, "GHOST") and Schema:IsCombineRank(value, "GHOST")) then
		character:SetModel("models/eliteghostcp.mdl")
	end
end

FACTION_MPF = FACTION.index
