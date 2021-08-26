
local SCANNER_SOUNDS = {
	"npc/scanner/scanner_blip1.wav",
	"npc/scanner/scanner_scan1.wav",
	"npc/scanner/scanner_scan2.wav",
	"npc/scanner/scanner_scan4.wav",
	"npc/scanner/scanner_scan5.wav",
	"npc/scanner/combat_scan1.wav",
	"npc/scanner/combat_scan2.wav",
	"npc/scanner/combat_scan3.wav",
	"npc/scanner/combat_scan4.wav",
	"npc/scanner/combat_scan5.wav",
	"npc/scanner/cbot_servoscared.wav",
	"npc/scanner/cbot_servochatter.wav"
}

function PLUGIN:CreateScanner(client, isClawScanner)
	if (IsValid(client.ixScn)) then
		return
	end

	local entity = ents.Create("ix_scanner")
	if (not IsValid(entity)) then
		return
	end

	for _, scanner in ipairs(ents.FindByClass("ix_scanner")) do
		if (scanner:GetPilot() == client) then
			scanner:SetPilot(NULL)
		end
	end

	entity:SetPos(client:GetPos())
	entity:SetAngles(client:GetAngles())
	entity:SetColor(client:GetColor())
	entity:Spawn()
	entity:Activate()
	entity:SetPilotEntity(client)

	if (isClawScanner) then
		entity:SetClawScanner()
	end

	entity:SetNetVar("player", client)
	client.ixScn = entity

	return entity
end

function PLUGIN:PlayerSpawn(client)
	timer.Simple(0.1, function()
		if (IsValid(client.ixScn)) then
			client.ixScn.noRespawn = true
			client.ixScn.spawn = client:GetPos()
			client.ixScn:Remove()
			client.ixScn = nil
			client:SetViewEntity(NULL)
		end
	end)
end

function PLUGIN:PlayerLoadedCharacter(client)
	net.Start("ixScannerClearPicture")
	net.Send(client)
end

function PLUGIN:DoPlayerDeath(client)
	if (IsValid(client.ixScn)) then
		client:AddDeaths(1)
		return false
	end
end

function PLUGIN:PlayerDeath(client)
	if (IsValid(client.ixScn) and client.ixScn.health > 0) then
		client.ixScn:Die()
		client.ixScn = nil
	end
end

function PLUGIN:KeyPress(client, key)
	if (IsValid(client.ixScn) and (client.ixScnDelay or 0) < CurTime()) then
		local source

		if (key == IN_USE) then
			source = table.Random(SCANNER_SOUNDS)
			client.ixScnDelay = CurTime() + 1.75
		elseif (key == IN_RELOAD) then
			source = "npc/scanner/scanner_talk"..math.random(1, 2)..".wav"
			client.ixScnDelay = CurTime() + 10
		elseif (key == IN_WALK) then
			if (client:GetViewEntity() == client.ixScn) then
				client:SetViewEntity(NULL)
			else
				client:SetViewEntity(client.ixScn)
			end
		end

		if (source) then
			client.ixScn:EmitSound(source)
		end
	end
end

function PLUGIN:PlayerNoClip(client)
	if (IsValid(client.ixScn)) then
		return false
	end
end

function PLUGIN:PlayerUse(client, entity)
	if (IsValid(client.ixScn)) then
		return false
	end
end

function PLUGIN:CanPlayerReceiveScan(client, photographer)
	return client.IsCombine and client:IsCombine()
end

function PLUGIN:PlayerSwitchFlashlight(client, enabled)
	local scanner = client.ixScn
	if (not IsValid(scanner)) then return end

	if ((scanner.nextLightToggle or 0) >= CurTime()) then return false end
	scanner.nextLightToggle = CurTime() + 0.5

	local pitch
	if (scanner:IsSpotlightOn()) then
		scanner:DisableSpotlight()
		pitch = 240
	else
		scanner:EnableSpotlight()
		pitch = 250
	end

	scanner:EmitSound("npc/turret_floor/click1.wav", 50, pitch)
	return false
end

function PLUGIN:PlayerFootstep(client)
	if (IsValid(client.ixScn)) then
		return true
	end
end

function PLUGIN:PlayerRankChanged(client)
	if (IsValid(client.ixScn)) then
		client:Spawn()
	end
end
