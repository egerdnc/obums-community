CLASS.name = "i4"
CLASS.faction = FACTION_MPF
CLASS.isDefault = true

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "i4")
end

CLASS_I4 = CLASS.index
