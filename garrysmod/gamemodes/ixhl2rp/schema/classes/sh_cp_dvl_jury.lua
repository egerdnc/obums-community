CLASS.name = "JURY DvL"
CLASS.faction = FACTION_MPF
CLASS.isDefault = false

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "JURY-DvL")
end

function CLASS:OnSet(client)
	local character = client:GetCharacter()
	  character:SetModel("models/dpfilms/metropolice/elite_police.mdl")
  	local inventory = character:GetInventory()
  	local itemFilter = {"mp7"}
  	if (inventory:HasItems(itemFilter)) then
	  return
  	else
	  	inventory:Add("mp7", 1)
	  	inventory:Add("division", 1)
  	end
end

CLASS_JURYDVL = CLASS.index
