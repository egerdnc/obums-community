
PLUGIN.name = "Doorkick"
PLUGIN.author = "B4tr1p"
PLUGIN.description = "Adds doorkick to the server."


ix.config.Add("strneeded", 0.5, "How much strength is needed to kick a dor.", nil, {
	data = {min = 0, max = 30.0, decimals = 1},
	category = "Doorkick"
})


ix.config.Add("combineonly", true, "Whether or not doorkick is restricted to combines the server.", nil, {
	category = "Doorkick"
})


ix.command.Add("Doorkick", {
    description = "Kick the door.",
    adminOnly = true,

	OnRun = function(self, client, arguments)

		-- Get the door the player is looking at.
		local entity = client:GetEyeTrace().Entity
		-- Validate it is a door.
		print(client:IsCombine())
		if (!client:IsCombine()) then return end
		if (IsValid(entity) and entity:IsDoor() and !entity:GetNetVar("disabled")) then
			if (client:GetPos():Distance(entity:GetPos())< 100) then	
				if (client:GetCharacter():GetAttribute("str", 0)) then	
					client:ForceSequence("kickdoorbaton")
					timer.Simple(0.8, function()	
						entity:EmitSound("physics/wood/wood_plank_break1.wav")
					end)
					timer.Simple(1, function()	
						local chance = math.random(1, 2)	
						if chance == 2 then
							entity:Fire("unlock")
							entity:Fire("open")
							entity:Fire("setanimation", "open", .6)
							entity:EmitSound("physics/wood/wood_crate_break3.wav")
						end
					end)
				else
					client:Notify("You are not strong enough to perform this action!")
				end
			else
				client:Notify("You are not close enough!")
			end
		else
			client:Notify("You are not looking at a door!")
		end
	end
})
