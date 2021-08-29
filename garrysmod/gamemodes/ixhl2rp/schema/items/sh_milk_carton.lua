
ITEM.name = "Milk Carton"
ITEM.model = Model("models/props_junk/garbage_milkcarton001a.mdl")
ITEM.width = 1
ITEM.weight = 0.5
ITEM.height = 1
ITEM.illegal = false
ITEM.description = "A carton filled with milk."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Drink = {
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 10, client:GetMaxHealth()))

		return true
	end,
}
