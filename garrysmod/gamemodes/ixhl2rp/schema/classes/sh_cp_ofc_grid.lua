CLASS.name = "GRID OfC"
CLASS.faction = FACTION_MPF
CLASS.isDefault = false

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "GRID-OfC")
end

function CLASS:OnSet(client)
  	local character = client:GetCharacter()
		character:SetModel("models/dpfilms/metropolice/hl2concept.mdl")
	local inventory = character:GetInventory()
	local item = inventory:HasItem("mp7")
	if (item) then
		return
	else
		inventory:Add("mp7", 1)
	end
end

CLASS_OFCGRID = CLASS.index
