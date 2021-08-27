local PLUGIN = PLUGIN

local chatterSounds = {
	"METROPOLICE_IDLE7",
	"METROPOLICE_IDLE6",
	"METROPOLICE_IDLE_CR7",
	"METROPOLICE_IDLE_CR17",
	"METROPOLICE_IDLE_CR16",
	"METROPOLICE_IDLE_CR15",
	"METROPOLICE_IDLE_CR10",
}

local chatterSoundsO = {
	"COMBINE_IDLE0",
	"COMBINE_IDLE3",
	"COMBINE_IDLE2",
	"COMBINE_IDLE4",
	"COMBINE_QUEST5",
	"COMBINE_ANSWER4",
	"COMBINE_CLEAR1",
	"COMBINE_CHECK2",
}
local nextSound = CurTime()
local function metroTalk()

	if CurTime() > nextSound then

		nextSound = CurTime() + math.random(15, 45)
		for k,v in pairs(player.GetAll()) do -- in a think hook yes i know
			if v:GetMoveType() == MOVETYPE_NOCLIP then return end
			if v:Team() == FACTION_MPF then
				EmitSentence(chatterSounds[math.random(#chatterSounds)], v:GetPos(), v:EntIndex())
			end
		end
	end
end
hook.Add( "OnPlayerChat", "metroTalk", metroTalk )

local nextSoundO = CurTime()
local function overwatchTalk()

	if CurTime() > nextSoundO then

		nextSoundO = CurTime() + math.random(30, 80)
		for k, v in pairs(player.GetAll()) do
			if v:GetMoveType() == MOVETYPE_NOCLIP then return end 
			if v:Team() == FACTION_OTA then
				EmitSentence(chatterSoundsO[math.random(#chatterSoundsO)], v:GetPos(), v:EntIndex())
			end
		end
	end
end
hook.Add( "Think", "overwatchTalk", overwatchTalk )
