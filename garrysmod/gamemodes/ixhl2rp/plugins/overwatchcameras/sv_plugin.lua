
local PLUGIN = PLUGIN

local hatedWeapons = {
	["weapon_pistol"] = true,
	["weapon_357"] = true,
	["weapon_crossbow"] = true,
	["weapon_frag"] = true,
	["weapon_ar2"] = true,
	["weapon_rpg"] = true,
	["weapon_slam"] = true,
	["weapon_shotgun"] = true,
	["weapon_smg1"] = true,
	["ls_uspmatch"] = true,
	["ls_csniper"] = true,
	["ls_spas12"] = true,
	["ls_m24"] = true,
	["ls_oicw"] = true,
	["ls_mp5k"] = true,
	["ls_mp7"] = true,
	["ls_357"] = true
}

function PLUGIN:GetCameraRelationship(client)
	if (client:IsCombine()) then return D_LI end

	local weapon = client:GetActiveWeapon()

	if (IsValid(weapon)) then
		local weaponClass = weapon:GetClass()

		if (hatedWeapons[weaponClass]) then
			return D_HT, "@relationArmed"
		end
	end

	if (client:GetNWBool("IsConcealed")) then
		return D_HT, "@relationUPI"
	end

	if (client:Team() == FACTION_VORTIGAUNT) then
		return D_HT, "@relationVort"
	elseif (client:Team() == FACTION_ANTLION) then
		return D_HT, "@relationAntlion", Color(255, 255, 0)
	elseif (client:Team() == FACTION_ZOMBIE) then
		return D_HT, "@relationZombie", Color(255, 255, 0)
	end

	return D_NU
end

function PLUGIN:OnFoundPlayer(entity, client)
	local relationship, notice, color = self:GetCameraRelationship(client)

	if (relationship == D_HT) then
		local name = entity:GetName() != "" and entity:GetName() or "OVERWATCH"

		entity:Fire("SetAngry")
		entity:Fire("SetIdle", "", 5)
		entity:SetNWBool("Alert", true)

		timer.Simple(5, function()
			if (IsValid(entity)) then
				entity:SetNWBool("Alert", false)
			end
		end)

		if (Schema.AddCombineDisplayMessage and notice) then
			Schema:AddCombineDisplayMessage(notice, color or Color(255, 0, 0), 30, name)
		end

		if (Schema.AddWaypoint and notice) then
			Schema:AddWaypoint(client:GetPos(), notice, color or Color(255, 0, 0), 30, nil, name)
		end
	end
end

function PLUGIN:OnDestroyed(entity, client)
	local name = entity:GetName() != "" and entity:GetName() or "OVERWATCH"

	if (Schema.AddCombineDisplayMessage) then
		Schema:AddCombineDisplayMessage("@cameraDestroyed", color or Color(255, 0, 0), 30, name)
	end

	if (Schema.AddWaypoint) then
		Schema:AddWaypoint(entity:GetPos(), "@cameraDestroyed", color or Color(255, 0, 0), 30, nil, name)
	end
end
