
ITEM.name = "Comlight"
ITEM.model = Model("models/Items/battery.mdl")
ITEM.width = 1
ITEM.height = 2
ITEM.description = "A standard issue flashlight used by the Union."
ITEM.category = "Tools"

ITEM:Hook("drop", function(item)
	item.player:Comlight(false)
end)
