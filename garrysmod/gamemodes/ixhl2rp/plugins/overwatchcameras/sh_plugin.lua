
local PLUGIN = PLUGIN

PLUGIN.name = "Overwatch Cameras"
PLUGIN.author = "wowm0d"
PLUGIN.description = "Adds functioning overwatch cameras."

PLUGIN.cameras = PLUGIN.cameras or {}

function PLUGIN:GetReceivers()
	local receivers = {}

	for _, client in pairs(player.GetAll()) do
		local factionTable = ix.faction.Get(client:Team())

		if (factionTable.canViewCameras) then
			table.insert(receivers, client)
		end
	end

	return receivers
end

ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

local persistence = ix.plugin.list["persistence"]

function PLUGIN:SetupCamera(entity)
	if (!IsValid(self.cameraController) and SERVER) then
		for _, entity in pairs(ents.FindByName("_cameraController")) do
			SafeRemoveEntity(entity)
		end

		self.cameraController = ents.Create("base_entity")
		self.cameraController:SetName("_cameraController")

		self.cameraController.AcceptInput = function(this, inputName, activator, caller, data)
			if (inputName == "OnFoundPlayer") then
				self:OnFoundPlayer(caller, activator)
			elseif (inputName == "OnDestroyed") then
				self:OnDestroyed(caller, activator)
			end
		end
	end

	local pos, ang = entity:GetPos(), entity:GetAngles()

	if (!self.cameras[entity]) then
		self.cameras[entity] = true

		entity:SetKeyValue("innerradius", 400)
		entity:SetKeyValue("outerradius", 800)
		entity:SetKeyValue("OnFoundPlayer", "_cameraController,OnFoundPlayer")

		if (SERVER) then
			entity:Fire("addoutput", "OnDamaged _cameraController:OnDestroyed:0:-1")
			entity:AddRelationship("player D_NU 90")
		end
	elseif (SERVER) then
		self.cameras[entity] = nil
		SafeRemoveEntity(entity)

		local camera = ents.Create("npc_combine_camera")
		camera:SetPos(pos) ; camera:SetAngles(ang)
		camera:SetKeyValue("spawnflags", "128")
		camera:Spawn()

		if (persistence and entity:GetNetVar("Persistent", false)) then
			persistence.stored[#persistence.stored + 1] = camera
			camera:SetNetVar("Persistent", true)
		end

		camera:Fire("Enable")
	end
end
