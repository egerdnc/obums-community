CLASS.name = "VICE SqL"
CLASS.faction = FACTION_MPF
CLASS.isDefault = false

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "VICE-SqL")
end

function CLASS:OnSet(client)
  	local character = client:GetCharacter()
		character:SetModel("models/metropolice/eliteshockcp_v2.mdl")
	local inventory = character:GetInventory()
	local itemFilter = {"mp7", "shotgun"}
	if (inventory:HasItems(itemFilter)) then
		return
	else
		inventory:Add("mp7", 1)
		inventory:Add("shotgun", 1)
	end
end

CLASS_SQLVICE = CLASS.index
