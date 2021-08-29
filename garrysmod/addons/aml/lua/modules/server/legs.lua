BrokenLegs = {}

-- @ply | Player object that Gmod gives us
--@attacker | Attacker's player object that gmod gives us
-- returns void
function FallLegs(ply, attacker)
	local runSpeed = ply:GetRunSpeed()
	local walkSpeed = ply:GetWalkSpeed()

	if ply:IsPlayer() and attacker:GetClass() == "worldspawn" then
		if ply:GetWalkSpeed() > r_walkspeed then
			ply:EmitSound( "vo/npc/male01/myleg01.wav" )
			ply:SetWalkSpeed( r_walkspeed )
			ply:SetRunSpeed( r_runspeed )
			ply:Notify("You broke your legs!")
			BrokenLegs[ply] = true
			
			timer.Simple(5, function()
				if BrokenLegs[ply] == true then
					timer.Simple(180, function()
						ply:SetRunSpeed(240)
						ply:SetWalkSpeed(124)
						ply:Notify("Your legs are good again!")
						BrokenLegs[ply] = false
					end)
				end
			end)
		end
	end
end

-- Hooks and Network Messages
hook.Add("PlayerHurt", "FallLegs", FallLegs)