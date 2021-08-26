CLASS.name = "i2"
CLASS.faction = FACTION_MPF
CLASS.isDefault = false

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "i2")
end

function FACTION:OnNameChanged(client, oldValue, value)
  local character = client:GetCharacter()
	if (!Schema:IsCombineRank(oldValue, "GRID") and Schema:IsCombineRank(value, "GRID")) then
		 character:SetModel("models/dpfilms/metropolice/hl2concept.mdl")
  elseif (!Schema:IsCombineRank(oldValue, "JURY") and Schema:IsCombineRank(value, "JURY")) then
		 character:SetModel("models/dpfilms/metropolice/policetrench.mdl")
  elseif (!Schema:IsCombineRank(oldValue, "UNION") and Schema:IsCombineRank(value, "UNION")) then
		 character:SetModel("models/dpfilms/metropolice/hdpolice.mdl")
  end
end

CLASS_I2 = CLASS.index
