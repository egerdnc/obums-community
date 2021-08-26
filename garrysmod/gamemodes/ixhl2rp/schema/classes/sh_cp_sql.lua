CLASS.name = "UNION SqL"
CLASS.faction = FACTION_MPF
CLASS.isDefault = false

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "UNION-SqL")
end

function CLASS:OnSet(client)
  local character = client:GetCharacter()
	character:SetModel("models/dpfilms/metropolice/hdpolice.mdl")
end

CLASS_SQL = CLASS.index
