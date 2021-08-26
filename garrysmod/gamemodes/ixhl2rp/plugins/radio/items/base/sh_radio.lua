
ITEM.name = "Radio Base"
ITEM.description = "A basic radio with a changable frequency."
ITEM.model = "models/deadbodies/dead_male_civilian_radio.mdl"
ITEM.category = "Communication"
ITEM.freqRadio = true

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local freq = tooltip:AddRowAfter("name", "frequency")
		freq:SetText(self.channel and ("Channel: "..self.channel) or ("Frequency: "..self:GetData("frequency", "000.0")))
		freq:SetBackgroundColor(derma.GetColor("Success", tooltip))
		freq:SizeToContents()
	end
end

ITEM.functions.Frequency = {
	OnCanRun = function(item)
		return !IsValid(item.entity) and !item.channel and item.freqRadio
	end,
	OnRun = function(item)
		net.Start("ixItemFrequency")
			net.WriteString(item:GetData("frequency", "000.0"))
			net.WriteUInt(item.id, 16)
		net.Send(item.player)

		return false
	end
}
