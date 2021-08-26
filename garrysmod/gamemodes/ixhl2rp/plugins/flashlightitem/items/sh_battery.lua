
ITEM.name = "Battery"
ITEM.model = Model("models/props_junk/battery.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A battery to charge a flashlight."
ITEM.category = "Miscellaneous"

ITEM.functions.Recargar = {
	OnRun = function(itemTable)
		local client = itemTable.player
		local character = client:GetCharacter()
		local inventory = character:GetInventory()
		local item = inventory:HasItem("flashlight")
		
		if(item and item:GetData("battery", 100)<100) then
			item:SetData("battery", (math.Clamp(item:GetData("battery", 100) + 50, 0, 100)))
			client:EmitSound("items/battery_pickup.wav")
		else
			client:Notify("No dispones de una linterna para cargar.")
			return false
		end
	end
}