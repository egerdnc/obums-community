
function PLUGIN:SetupTimer(client, character)
	local steamID = client:SteamID64()

	timer.Create("ixBattery" .. steamID, ix.config.Get("batteryTickTime", 20), 0, function()
		if (IsValid(client) and character) then
			self:BatteryTick(client, character, 10)
		else
			timer.Remove("ixBattery" .. steamID)
		end
	end)
	
end

function PLUGIN:SetupAllTimers()
	for _, v in ipairs(player.GetAll()) do
		local character = v:GetCharacter()

		if (character) then
			self:SetupTimer(v, character)
		end
	end
end

function PLUGIN:RemoveAllTimers()
	for _, v in ipairs(player.GetAll()) do
		timer.Remove("ixBattery" .. v:SteamID64())
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastCharacter)
	self:SetupTimer(client, character)
end

function PLUGIN:BatteryInit()
	self:SetupAllTimers()
end

function PLUGIN:BatteryTick(client, character, delta)
	if (!client:Alive() or client:GetMoveType() == MOVETYPE_NOCLIP or !character:GetInventory():HasItem("flashlight")) then
		return
	end

	-- update character battery
	local scale = 1
	
	local inventory = character:GetInventory()
	local item = inventory:HasItem("flashlight")
	local battery = item:GetData("battery", 100)
	local newBattery = math.Clamp(battery - scale * (delta / 10), 0, 100)
	
	if(client:FlashlightIsOn()) then
		item:SetData("battery", newBattery)
	end
	
	if (newBattery == 0) then
		client:Flashlight(false)
		client:AllowFlashlight(false)
	else client:AllowFlashlight(true)
	end
end

