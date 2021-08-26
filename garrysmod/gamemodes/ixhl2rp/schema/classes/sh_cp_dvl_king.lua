CLASS.name = "KING DvL"
CLASS.faction = FACTION_MPF
CLASS.isDefault = false

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "KING-DvL")
end

function CLASS:OnSet(client)
	local character = client:GetCharacter()
	  character:SetModel("models/dpfilms/metropolice/elite_police.mdl")
  	local inventory = character:GetInventory()
  	local itemFilter = {"mp7", "mp5k"}
  	if (inventory:HasItems(itemFilter)) then
	  return
  	else
	  inventory:Add("mp7", 1)
	  inventory:Add("mp5k", 1)
  	end
end

CLASS_KINGDVL = CLASS.index
