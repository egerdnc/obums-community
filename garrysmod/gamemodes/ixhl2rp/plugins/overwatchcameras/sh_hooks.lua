
local PLUGIN = PLUGIN

function PLUGIN:EntityRemoved(entity)
	if (self.cameras[entity]) then
		self.cameras[entity] = nil
	end
end

function PLUGIN:OnEntityCreated(entity)
	if (IsValid(entity) and entity:GetClass() == "npc_combine_camera") then
		self:SetupCamera(entity)
	end
end
