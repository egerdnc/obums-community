CLASS.name = "VICE DvL"
CLASS.faction = FACTION_MPF
CLASS.isDefault = false

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "VICE-DvL")
end

function CLASS:OnSet(client)
  local character = client:GetCharacter()
	character:SetModel("models/metropolice/eliteshockcp_v2.mdl")
end

CLASS_VICEDVL = CLASS.index
