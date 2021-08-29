
local PLUGIN = PLUGIN

function PLUGIN:HUDPaint()
	if (!IsValid(ix.gui.chat)) then return end

	local channelString = "none"
	local transmitString = "none"

	local channels = LocalPlayer():GetLocalVar("channels")
	local transmitChannel = LocalPlayer():GetLocalVar("transmitChannel")

	if (channels and table.Count(channels) > 0) then
		channelString = {}

		for k, v in pairs(channels) do
			local channel = ix.radio.Get(v)

			if (channel) then
				channelString[k] = channel.name
			else
			    channelString[k] = v
			end
		end

		channelString = table.concat(channelString, ", ")
	end

	if (transmitChannel) then
		local channel = ix.radio.Get(transmitChannel)

		if (channel) then
			transmitString = channel.name
		else
			transmitString = transmitChannel
		end
	end

	local textColor = ColorAlpha(color_white, ix.gui.chat:GetAlpha())
	local x, y = chat.GetChatBoxPos()

	draw.SimpleText("Radio Channels: "..channelString, "BudgetLabel", x, y - 36, textColor)
	draw.SimpleText("Transmit Channel: "..transmitString, "BudgetLabel", x, y - 18, textColor)
end

net.Receive("ixItemFrequency", function()
	local curFreq = net.ReadString()
	local itemID = net.ReadUInt(16)

	Derma_StringRequest("Radio Frequency", "Change this radios frequency.", curFreq, function(text)
		net.Start("ixItemFrequency")
			net.WriteUInt(itemID, 16)
			net.WriteString(text)
		net.SendToServer()
	end)
end)
