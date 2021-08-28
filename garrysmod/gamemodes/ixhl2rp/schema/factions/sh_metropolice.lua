FACTION.name = "Civil Protection"
FACTION.description = "Civil Protection units employed by an unkown larger group know as MPF."
FACTION.color = Color(50, 100, 150)
FACTION.models = {"models/dpfilms/metropolice/hdpolice.mdl"}
FACTION.isDefault = false
FACTION.runSounds = {[0] = "NPC_MetroPolice.RunFootstepLeft", [1] = "NPC_MetroPolice.RunFootstepRight"}
FACTION.Ranks = {
    [1] = {"UNION i4", nil, CLASS_I4},
    [2] = {"GRID i4", nil, CLASS_I4GRID},
    [3] = {"JURY i4", nil, CLASS_I4JURY},
    [4] = {"UNION i3", nil, CLASS_I3},
    [5] = {"GRID i3", nil, CLASS_I3GRID},
    [6] = {"JURY i3", nil, CLASS_I3JURY},
	[7] = {"UNION i2", nil, CLASS_I2},
    [8] = {"GRID i2", nil, CLASS_I2GRID},
    [9] = {"JURY i2", nil, CLASS_I2JURY},
    [10] = {"UNION i1", nil, CLASS_I1},
    [11] = {"GRID i1", nil, CLASS_I1GRID},
    [12] = {"JURY i1", nil, CLASS_I1JURY},
	[13] = {"UNION OfC", nil, CLASS_OFC},
    [14] = {"GRID OfC", nil, CLASS_OFCGRID},
    [15] = {"JURY OfC", nil, CLASS_OFCJURY},
	[16] = {"UNION SqL", nil, CLASS_SQL, true},
    [17] = {"GRID SqL", nil, CLASS_GRIDSQL, true},
    [18] = {"JURY SqL", nil, CLASS_JURYSQL, true},
	[19] = {"KING SqL", nil, CLASS_KINGSQL, true},
    [20] = {"VICE SqL", nil, CLASS_SQLVICE, true},
	[21] = {"UNION DvL", nil, CLASS_DVL, true},
    [22] = {"GRID DvL", nil, CLASS_GRIDDVL, true},
    [23] = {"JURY DvL", nil, CLASS_JURYDVL, true},
	[24] = {"KING DvL", nil, CLASS_KINGDVL, true},
    [25] = {"VICE DvL", nil, CLASS_VICEDVL, true}
}

FACTION.channels = {
	["union"] = true
}
FACTION.canSeeWaypoints = true
FACTION.canAddWaypoints = true
FACTION.canRemoveWaypoints = true
FACTION.canUpdateWaypoints = true


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

FACTION_MPF = FACTION.index
