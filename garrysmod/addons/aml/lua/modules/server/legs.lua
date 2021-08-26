function FallLegs(ply, attacker)
	if ply:IsPlayer() and attacker:GetClass() == "worldspawn" and r_falllegs == true then
		if ply:GetWalkSpeed() > r_walkspeed then
			ply:EmitSound( "vo/npc/male01/myleg01.wav" )
			ply:SetWalkSpeed( r_walkspeed )
			ply:SetRunSpeed( r_runspeed )
			ply:ChatPrint("You broke your legs!")
		end
	end
end
hook.Add("PlayerHurt", "FallLegs", FallLegs)