include("r_config.lua")

timer.Create( "HurtSound", r_moanfreq, 0, function() 
	if CLIENT then
		IsLegBroken = true
		if LocalPlayer():Health() <= r_hurtsoundshealth then
		LocalPlayer():EmitSound( "vo/npc/male01/moan02.wav" )
		end
	end
end)
