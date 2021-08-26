
local PLUGIN = PLUGIN

function PLUGIN:Think()
	local curTime = CurTime()

	if (!self.nextThink or self.nextThink < curTime) then
		for camera, _ in pairs(self.cameras) do
			if (IsValid(camera)) then
				for _, client in pairs(player.GetAll()) do
					camera:AddEntityRelationship(client, self:GetCameraRelationship(client), 98)
				end
			end
		end

		self.nextThink = curTime + 2
	end
end

function PLUGIN:PlayerUse(client, entity)
	if (client:IsCombine() and entity:GetClass() == "npc_combine_camera" and entity:Health() <= 0) then
		self:SetupCamera(entity)
	end
end

function PLUGIN:PlayerDeath(client, inflictor, attacker)
	if (!client:IsCombine()) then return end

	local nearDist = nil
	local camera = nil

	for entity, _ in pairs(self.cameras) do
		if (entity:IsLineOfSightClear(client)) then
			local dist = entity:GetPos():DistToSqr(client:GetPos())

			if ((!nearDist or nearDist > dist) and dist <= 400*400) then
				nearDist = dist
				camera = entity

				break
			end
		end
	end

	if (IsValid(camera)) then
		if (Schema.AddCombineDisplayMessage) then
			Schema:AddCombineDisplayMessage("@bioPacket", Color(255, 0, 0), 8, client:Name())
		end

		if (Schema.AddWaypoint) then
			Schema:AddWaypoint(client:GetPos(), "@bioWaypoint", Color(255, 0, 0), 30, nil, client:Name())
		end
	end
end
