CLASS.name = "JURY OfC"
CLASS.faction = FACTION_MPF
CLASS.isDefault = false

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "JURY-OfC")
end

function CLASS:OnSet(client)
  local character = client:GetCharacter()
	character:SetModel("models/dpfilms/metropolice/policetrench.mdl")
end

CLASS_OFCJURY = CLASS.index
