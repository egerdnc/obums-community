CLASS.name = "GRID i2"
CLASS.faction = FACTION_MPF
CLASS.isDefault = false

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "GRID-i2")
end

function CLASS:OnSet(client)
  local character = client:GetCharacter()
	character:SetModel("models/dpfilms/metropolice/hl2concept.mdl")
end

CLASS_I2GRID = CLASS.index
