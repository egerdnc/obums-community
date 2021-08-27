FACTION.name = "Civil Protection"
FACTION.description = "Civil Protection units employed by an unkown larger group know as MPF."
FACTION.color = Color(50, 100, 150)
FACTION.models = {"models/dpfilms/metropolice/hdpolice.mdl"}
FACTION.isDefault = false
FACTION.runSounds = {[0] = "NPC_MetroPolice.RunFootstepLeft", [1] = "NPC_MetroPolice.RunFootstepRight"}
FACTION.channels = {
	["union"] = true,
	["delegate"] = true
}

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()
	
	inventory:Add("flashlight", 1)
	inventory:Add("stunstick", 1)
end

function FACTION:GetDefaultName(client)
	return "C02.UNION-i4-" .. Schema:ZeroNumber(math.random(999, 9999), 4), true
end

function FACTION:OnTransferred(client)
	client:SetName(self:GetDefaultName())
	client:SetModel(self.models[1])
	client:AddCombineDisplayMessage("@cCombineLoaded")
end

function FACTION:OnNameChanged(client, oldValue, value)
	local character = client:GetCharacter()

	if (!Schema:IsCombineRank(oldValue, "UNION-i4") and Schema:IsCombineRank(value, "UNION-i4")) then
		character:JoinClass(CLASS_I4)
	elseif (!Schema:IsCombineRank(oldValue, "UNION-i3") and Schema:IsCombineRank(value, "UNION-i3")) then
		character:JoinClass(CLASS_I3)
	elseif (!Schema:IsCombineRank(oldValue, "UNION-i2") and Schema:IsCombineRank(value, "UNION-i2")) then
		character:JoinClass(CLASS_I2)
	elseif (!Schema:IsCombineRank(oldValue, "UNION-i1") and Schema:IsCombineRank(value, "UNION-i1")) then
		character:JoinClass(CLASS_I1)
	elseif (!Schema:IsCombineRank(oldValue, "UNION-OfC") and Schema:IsCombineRank(value, "UNION-OfC")) then
		character:JoinClass(CLASS_OFC)
	elseif (!Schema:IsCombineRank(oldValue, "UNION-SqL") and Schema:IsCombineRank(value, "UNION-SqL")) then
		character:JoinClass(CLASS_SQL)
	elseif (!Schema:IsCombineRank(oldValue, "UNION-DvL") and Schema:IsCombineRank(value, "UNION-DvL")) then
		character:JoinClass(CLASS_DVL)
	elseif (!Schema:IsCombineRank(oldValue, "GRID-i4") and Schema:IsCombineRank(value, "GRID-i4")) then
		character:JoinClass(CLASS_I4GRID)
	elseif (!Schema:IsCombineRank(oldValue, "GRID-i3") and Schema:IsCombineRank(value, "GRID-i3")) then
		character:JoinClass(CLASS_I3GRID)
	elseif (!Schema:IsCombineRank(oldValue, "GRID-i2") and Schema:IsCombineRank(value, "GRID-i2")) then
		character:JoinClass(CLASS_I2GRID)
	elseif (!Schema:IsCombineRank(oldValue, "GRID-i1") and Schema:IsCombineRank(value, "GRID-i1")) then
		character:JoinClass(CLASS_I1GRID)
	elseif (!Schema:IsCombineRank(oldValue, "GRID-OfC") and Schema:IsCombineRank(value, "GRID-OfC")) then
		character:JoinClass(CLASS_OFCGRID)
	elseif (!Schema:IsCombineRank(oldValue, "GRID-SqL") and Schema:IsCombineRank(value, "GRID-SqL")) then
		character:JoinClass(CLASS_GRIDSQL)
	elseif (!Schema:IsCombineRank(oldValue, "GRID-DvL") and Schema:IsCombineRank(value, "GRID-DvL")) then
		character:JoinClass(CLASS_GRIDDVL)
	elseif (!Schema:IsCombineRank(oldValue, "JURY-i4") and Schema:IsCombineRank(value, "JURY-i4")) then
		character:JoinClass(CLASS_I4JURY)
	elseif (!Schema:IsCombineRank(oldValue, "JURY-i3") and Schema:IsCombineRank(value, "JURY-i3")) then
		character:JoinClass(CLASS_I3JURY)
	elseif (!Schema:IsCombineRank(oldValue, "JURY-i2") and Schema:IsCombineRank(value, "JURY-i2")) then
		character:JoinClass(CLASS_I2JURY)
	elseif (!Schema:IsCombineRank(oldValue, "GRID-i1") and Schema:IsCombineRank(value, "JURY-i1")) then
		character:JoinClass(CLASS_I1JURY)
	elseif (!Schema:IsCombineRank(oldValue, "JURY-OfC") and Schema:IsCombineRank(value, "JURY-OfC")) then
		character:JoinClass(CLASS_OFCJURY)
	elseif (!Schema:IsCombineRank(oldValue, "JURY-SqL") and Schema:IsCombineRank(value, "JURY-SqL")) then
		character:JoinClass(CLASS_JURYSQL)
	elseif (!Schema:IsCombineRank(oldValue, "JURY-DvL") and Schema:IsCombineRank(value, "JURY-DvL")) then
		character:JoinClass(CLASS_JURYDVL)
	elseif (!Schema:IsCombineRank(oldValue, "KING-SqL") and Schema:IsCombineRank(value, "KING-SqL")) then
		character:JoinClass(CLASS_KINGSQL)
	elseif (!Schema:IsCombineRank(oldValue, "KING-DvL") and Schema:IsCombineRank(value, "KING-DvL")) then
		character:JoinClass(CLASS_KINGDVL)
	elseif (!Schema:IsCombineRank(oldValue, "VICE-SqL") and Schema:IsCombineRank(value, "VICE-SqL")) then
		character:JoinClass(CLASS_SQLVICE)
	elseif (!Schema:IsCombineRank(oldValue, "VICE-DvL") and Schema:IsCombineRank(value, "VICE-DvL")) then
		character:JoinClass(CLASS_VICEDVL)
	end

end

FACTION_MPF = FACTION.index
