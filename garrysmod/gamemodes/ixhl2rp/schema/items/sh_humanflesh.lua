ITEM.name = "Human Flesh"
ITEM.model = Model("models/props_junk/watermelon01.mdl")
ITEM.width = 1
ITEM.weight = 2
ITEM.height = 1
ITEM.description = "Harvested flesh from a human, smells vile, don't eat this."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() - 25, client:GetMaxHealth()))
		client:EmitSound("npc/barnacle/barnacle_gulp2.wav", 75, 90, 0.35)
		return true
	end,
}
