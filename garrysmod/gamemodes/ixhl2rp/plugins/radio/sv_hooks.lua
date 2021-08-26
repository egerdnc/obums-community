
local PLUGIN = PLUGIN

function PLUGIN:CanAutoFormatMessage(client, chatType, message)
	if (chatType == "radio_transmit" or chatType == "radio_eavesdrop") then
		return true
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	ix.radio.ResetPlayerChannels(client)
end

function PLUGIN:CanHearRadioTrasmit(client, data)
	local channel = data.channelID

	if (ix.radio.PlayerHasChannel(client, channel, !data.actualChannel)) then
		return true
	end
end

function PLUGIN:CanEavesdropRadioTrasmit(client, data, transmitPos)
	if (client:GetPos():DistToSqr(transmitPos) <= data.range^2) then
		return true
	end
end

function PLUGIN:OnResetPlayerChannels(client)
	local items = client:GetItems()

	local bFreqRadio = false

	for _, v in pairs(items or {}) do
		if (v.base != "base_radio") then continue end

		if (v.channel and ix.radio.Get(v.channel)) then
			ix.radio.AddChannelToPlayer(client, v.channel)
		elseif (v:GetData("frequency", "000.0") != "000.0" and v.freqRadio) then
		    ix.radio.AddChannelToPlayer(client, "FREQ "..v:GetData("frequency"), true)

		    bFreqRadio = true
		end
	end

	local transmitChannel = client:GetLocalVar("transmitChannel")

	if (!transmitChannel or !ix.radio.PlayerHasChannel(client, transmitChannel, bFreqRadio)) then
		ix.radio.ResetPlayerTransmitChannel(client, bFreqRadio)
	end
end

function PLUGIN:InventoryItemAdded(oldInv, inventory, item)
	if (!inventory.owner) then
		if (oldInv and oldInv.owner) then
			if (item.base == "base_radio") then
				ix.radio.ResetPlayerChannels(oldInv:GetOwner())
			end
		end

		return
	end

	if (oldInv and oldInv.owner == inventory.owner) then return end

	if (item.base == "base_radio") then
		ix.radio.ResetPlayerChannels(inventory:GetOwner())
	end
end

function PLUGIN:InventoryItemRemoved(inventory, item)
	if (!inventory.owner) then return end

	local client = inventory:GetOwner()

	if (item.base == "base_radio") then
		timer.Simple(0.1, function()
			ix.radio.ResetPlayerChannels(client)
		end)
	end
end

net.Receive("ixItemFrequency", function(length, client)
	local itemID = net.ReadUInt(16)
	local freq = net.ReadString()

	local item = client:GetCharacter():GetInventory():GetItemByID(itemID)

	if (item and freq:find("^%d%d%d.%d$")) then
		if (tonumber(freq) >= 100.0) then
			item:SetData("frequency", freq)

			ix.radio.ResetPlayerChannels(client)
		else
			return false
		end
	else
		return false
	end
end)
