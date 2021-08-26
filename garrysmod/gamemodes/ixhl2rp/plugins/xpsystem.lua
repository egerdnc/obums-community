--[[---------------------------------------------------------------------------
	** Copyright (c) 2021 Connor ---- (ZIKE)
	** This file is private and may not be shared, downloaded, used, sold or even copied.
---------------------------------------------------------------------------]]--

local PLUGIN = PLUGIN

PLUGIN.name = "Seperate XP"
PLUGIN.author = "ZIKE"
PLUGIN.description = "..."
PLUGIN.license = [[
	** Copyright (c) 2021 Connor ---- (ZIKE)
	** This file is private and may not be shared, downloaded, used, sold or even copied.
]]

if SERVER then

function PLUGIN:PlayerInitialSpawn(ply)
	if (ply:GetPData("ocCitizenXP", 0) == nil) or (ply:GetPData("ocCombineXP", 0) == nil) then
		ply:SetPData("ocCitizenXP", 0)
		ply:SetPData("ocCombineXP", 0)
	end
	if ply:IsStaffMember() or ply:IsAdmin() or ply:IsSuperAdmin() then
		timer.Create(ply:SteamID64().."_XPTimer", 1800, 0, function()
			if ply:IsCombine() then
				ply:Notify("You have gained 2 Combine XP!")
				ply:SetPData("ocCombineXP", ply:GetPData("ocCombineXP") + 2)
				ply:SetNWInt("ocCombineXP", ply:GetPData("ocCombineXP") + 2)
				ocXPCheck(ply)
				print("Gained VIP Combine XP.")
			else
				ply:Notify("You have gained 2 Citizen XP!")
				ply:SetPData("ocCitizenXP", ply:GetPData("ocCitizenXP") + 2)
				ply:SetNWInt("ocCitizenXP", ply:GetPData("ocCitizenXP") + 2)
				ocXPCheck(ply)
				print("Gained VIP Citizen XP.")
			end
		end)
	else
		timer.Create(ply:SteamID64().."_XPTimer", 900, 0, function()
			if ply:IsCombine() then
				ply:Notify("You have gained 1 Combine XP!")
				ply:SetPData("ocCombineXP", ply:GetPData("ocCombineXP") + 1)
				ply:SetNWInt("ocCombineXP", ply:GetPData("ocCombineXP") + 1)
				ocXPCheck(ply)
				print("Gained Combine XP.")
			else
				ply:Notify("You have gained 1 Citizen XP!")
				ply:SetPData("ocCitizenXP", ply:GetPData("ocCitizenXP") + 1)
				ply:SetNWInt("ocCitizenXP", ply:GetPData("ocCitizenXP") + 1)
				ocXPCheck(ply)
				print("Gained Citizen XP.")
			end
		end)
		print("User Timer Started.")
	end
	ply:SetNWInt("ocCitizenXP", ply:GetPData("ocCitizenXP"))
	ply:SetNWInt("ocCombineXP", ply:GetPData("ocCombineXP"))
	ocXPCheck(ply)
end

function PLUGIN:PlayerDisconnected(ply)
	print(ply:SteamName().." Disconnected, their XP has been Saved.")
	timer.Destroy(ply:SteamID64().. "_XPTimer")
end

function ocXPCheck(ply)
	for k, v in pairs(Schema.xpteams) do
		if v.isdonator then
			if tonumber(ply:GetNWInt(v.xptype, 0)) >= v.xpamount then
				if v.isclass then
					ply:SetClassWhitelisted(v.classid, true)
					print("whitelisted to "..k.." class")
				else
					ply:SetWhitelisted(v.factionid, true)
					print("whitelisted to "..k.." faction")
				end
			else
				if v.isclass then
					ply:SetClassWhitelisted(v.classid, false)
					print("blacklisted to "..k.." class")
				else
					ply:SetWhitelisted(v.factionid, false)
					print("blacklisted to "..k.." faction")
				end
			end
		else
			if ply:IsDonator() or ply:IsStaffMember() then
				if v.isclass then
					ply:SetClassWhitelisted(v.factionid, true)
					print("whitelisted to "..k.." class")
				else
					ply:SetWhitelisted(v.factionid, true)
					print("whitelisted to "..k.." faction")
				end
			else
				if v.isclass then
					ply:SetClassWhitelisted(v.classid, false)
					print("blacklisted to "..k.." class")
				else
					ply:SetWhitelisted(v.factionid, false)
					print("blacklisted to "..k.." faction")
				end
			end
		end
	end
end

function ocXPSetCitizen(ply, cmd, args)
	if not ply:IsSuperAdmin() then return end
	local target = ix.util.FindPlayer(args[1])
	if target then
		if args[2] then
			target:SetPData("ocCitizenXP", args[2])
			target:SetNWInt("ocCitizenXP", args[2])
			ocXPCheck(target)
		else
			ply:Notify("Please specify a amount.")
		end
	else
		ply:Notify("Please specify a user.")
	end
end
concommand.Add("oc_xp_setcitizen", ocXPSetCitizen)

function ocXPSetCombine(ply, cmd, args)
	if not ply:IsSuperAdmin() then return end
	local target = ix.util.FindPlayer(args[1])
	if target then
		if args[2] then
			target:SetPData("ocCombineXP", args[2])
			target:SetNWInt("ocCombineXP", args[2])
			ocXPCheck(target)
		else
			ply:Notify("Please specify a amount.")
		end
	else
		ply:Notify("Please specify a user.")
	end
end
concommand.Add("oc_xp_setcombine", ocXPSetCombine)

function ocXPShow(ply, cmd, args)
	if not ply:IsStaffMember() then return end
	local target = ix.util.FindPlayer(args[1])
	if target then
		ply:ChatPrint("===== "..target:Nick().." XP Count =====")
		ply:ChatPrint("Citizen XP: "..target:GetNWInt("ocCitizenXP", 0))
		ply:ChatPrint("Combine XP: "..target:GetNWInt("ocCombineXP", 0))
	end
end
concommand.Add("oc_xp_show", ocXPShow)

function ocXPGet(ply, cmd, args)
	ply:ChatPrint("===== "..ply:Nick().." XP Count =====")
	ply:ChatPrint("Citizen XP: "..ply:GetNWInt("ocCitizenXP", 0))
	ply:ChatPrint("Combine XP: "..ply:GetNWInt("ocCombineXP", 0))
end
concommand.Add("oc_xp_get", ocXPGet)

end
