
local PLUGIN = PLUGIN

ix.radio = ix.radio or {}
ix.radio.channels = {}
ix.radio.indices = {}

function ix.radio.LoadFromDir(path)
	for _, v in ipairs(file.Find(path.."/*.lua", "LUA")) do
		local niceName = v:sub(4, -5)

		ix.radio.RegisterChannel(niceName, path.."/"..v, false, nil)
	end
end

function ix.radio.RegisterChannel(uniqueID, path, luaGenerated, channelTable)
	CHANNEL = {index = table.Count(ix.radio.channels) + 1}
		if (!luaGenerated and path) then
			ix.util.Include(path, "shared")
		elseif (luaGenerated and channelTable) then
			table.Merge(CHANNEL, channelTable)
		end

		CHANNEL.name = CHANNEL.name or "Unknown"
		CHANNEL.color = CHANNEL.color or Color(25, 175, 25)
		CHANNEL.uniqueID = CHANNEL.uniqueID or uniqueID

		ix.radio.indices[CHANNEL.index] = CHANNEL
		ix.radio.channels[CHANNEL.uniqueID] = CHANNEL
	CHANNEL = nil
end

if (SERVER) then
	function ix.radio.ResetPlayerChannels(client)
		client:SetLocalVar("channels", {})

		if (client:GetCharacter()) then
			local factionTable = ix.faction.Get(client:Team())

			if (factionTable and factionTable.channels) then
				for uniqueID, _ in pairs(factionTable.channels) do
					ix.radio.AddChannelToPlayer(client, uniqueID)
				end
			end
		end

		timer.Simple(0.1, function()
			hook.Run("OnResetPlayerChannels", client)
		end)

		local transmitChannel = client:GetLocalVar("transmitChannel")

		if (!transmitChannel or !ix.radio.PlayerHasChannel(client, transmitChannel)) then
			ix.radio.ResetPlayerTransmitChannel(client)
		end
	end

	function ix.radio.ResetPlayerTransmitChannel(client, bForce)
		local channels = client:GetLocalVar("channels")

		if (table.Count(channels) > 0) then
			local randomChannel = channels[math.random(#channels)]

			if (ix.radio.Get(randomChannel) or bForce) then
				client:SetLocalVar("transmitChannel", randomChannel)
			else
				ix.radio.RemoveChannelFromPlayer(client, randomChannel, true)

				ix.radio.ResetPlayerTransmitChannel(client)
			end
		else
			client:SetLocalVar("transmitChannel", nil)
		end
	end

	function ix.radio.RemoveChannelFromPlayer(client, uniqueID, bForce)
		local channel = ix.radio.Get(uniqueID)

		if (channel or bForce) then
			local channels = client:GetLocalVar("channels")

			if (!table.HasValue(channels, uniqueID)) then return end

			table.RemoveByValue(channels, uniqueID)

			client:SetLocalVar("channels", channels)

			if (uniqueID == client:GetLocalVar("transmitChannel")) then
				ix.radio.ResetPlayerTransmitChannel(client, bForce)
			end
		end
	end

	function ix.radio.AddChannelToPlayer(client, uniqueID, bForce)
		local channel = ix.radio.Get(uniqueID)

		if (channel or bForce) then
			local channels = client:GetLocalVar("channels")

			if (table.HasValue(channels, uniqueID)) then return end

			table.insert(channels, uniqueID)

			client:SetLocalVar("channels", channels)
		end
	end

	function ix.radio.SetPlayerTransmitChannel(client, uniqueID, bForce)
		local channel = ix.radio.Get(uniqueID)

		if ((channel or bForce) and ix.radio.PlayerHasChannel(client, uniqueID, bForce)) then
			client:SetLocalVar("transmitChannel", uniqueID)
		end
	end

	function ix.radio.PlayerHasChannel(client, uniqueID, bForce)
		local channel = ix.radio.Get(uniqueID)

		if (channel or bForce) then
			return table.HasValue(client:GetLocalVar("channels"), uniqueID)
		else
		    return false
		end
	end

	function ix.radio.SayRadio(client, message, data)
		local channel = client:GetLocalVar("transmitChannel")
		data = data or {}

		if (data.channel) then
			channel = data.channel
		end

		data.actualChannel = ix.radio.Get(channel)

		if (channel) then
			data.range = ix.config.Get("chatRange", 280)
			data.prefix = "radios"

			if (data.chatType == "y") then
				data.range = data.range * 2
				data.prefix = "yells"
			elseif (data.chatType == "w") then
				data.range = data.range * 0.25
				data.prefix = "whispers"
			end

			if (data.actualChannel) then
				data.channelID = data.actualChannel.uniqueID
				data.channel = data.actualChannel.name

				data.color = data.color or data.actualChannel.color
			else
			    data.channelID = channel
				data.channel = channel
			end

			local receivers = {}
			local eavesdroppers = {}

			local clientPos = client:GetPos()

			for k, v in pairs(player.GetAll()) do
				if (!IsValid(v) or !v:Alive()) then continue end

				if (hook.Run("CanHearRadioTrasmit", v, data) or v == client) then
					receivers[#receivers + 1] = v
				elseif (hook.Run("CanEavesdropRadioTrasmit", v, data, clientPos)) then
					eavesdroppers[#eavesdroppers + 1] = v
				end
			end

			ix.chat.Send(client, "radio_transmit", message, false, receivers, data)
			ix.chat.Send(client, "radio_eavesdrop", message, false, eavesdroppers, data)
		else
			return "You are not on a valid radio channel!"
		end
	end
end

function ix.radio.Get(identifier)
	return ix.radio.indices[identifier] or ix.radio.channels[identifier]
end

function ix.radio.GetIndex(uniqueID)
	for k, v in ipairs(ix.radio.indices) do
		if (v.uniqueID == uniqueID) then
			return k
		end
	end
end

hook.Add("DoPluginIncludes", "ixRadio", function(path, pluginTable)
	ix.radio.LoadFromDir(path.."/channels")
end)
