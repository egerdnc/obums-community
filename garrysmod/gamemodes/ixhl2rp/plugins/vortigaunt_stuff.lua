PLUGIN.name = "Vortigaunt Faction"
PLUGIN.author = "JohnyReaper"
PLUGIN.description = "Adds some features for vortigaunts."

ix.config.Add("VortHealMin", 5, "Minimum health value that can be healed by vortigaunt" , nil, {
	data = {min = 1, max = 100},
	category = "Vortigaunt Healing Swep"
})

ix.config.Add("VortHealMax", 20, "Maximum health value that can be healed by vortigaunt" , nil, {
	data = {min = 1, max = 100},
	category = "Vortigaunt Healing Swep"
})


-- Fix default vortigaunt animations
ix.anim.vort = {
	normal = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_ANGRY},
		[ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
		["attack"] = ACT_MELEE_ATTACK1
	},
	melee = {
		["attack"] = ACT_MELEE_ATTACK1,
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_ANGRY},
		[ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN_AIM},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
	},
	grenade = {
		["attack"] = ACT_MELEE_ATTACK1,
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_ANGRY},
		[ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK}
	},
	pistol = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "TCidlecombat"},
		[ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
		["reload"] = ACT_IDLE,
		[ACT_MP_RUN] = {ACT_RUN, "run_all_TC"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, "Walk_all_TC"}
	},
	shotgun = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "TCidlecombat"},
		[ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
		["reload"] = ACT_IDLE,
		[ACT_MP_RUN] = {ACT_RUN, "run_all_TC"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, "Walk_all_TC"}
	},
	smg = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "TCidlecombat"},
		[ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
		["reload"] = ACT_IDLE,
		[ACT_MP_RUN] = {ACT_RUN, "run_all_TC"},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, "Walk_all_TC"}
	},
	beam = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE_ANGRY},
		[ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
		attack = ACT_GESTURE_RANGE_ATTACK1,
		["reload"] = ACT_IDLE,
		["glide"] = {ACT_RUN, ACT_RUN}
	},
	sweep = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, "sweep_idle"},
		[ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {"Walk_all_HoldBroom", "Walk_all_HoldBroom"},
		-- attack = "sweep",
	},
	heal = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_CROUCH_IDLE] = {"crouchidle", "crouchidle"},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
	},
	glide = ACT_GLIDE
}

//Default vorts
ix.anim.SetModelClass("models/vortigaunt.mdl", "vort")
ix.anim.SetModelClass("models/vortigaunt_slave.mdl", "vort")
ix.anim.SetModelClass("models/vortigaunt_blue.mdl", "vort")
ix.anim.SetModelClass("models/vortigaunt_doctor.mdl", "vort")

//Ozaxi's vortigaunt
ix.anim.SetModelClass("models/vortigaunt_ozaxi.mdl", "vort")
//Better Vortigaunts addon
ix.anim.SetModelClass("models/kw/kw_vortigaunt.mdl", "vort")
ix.anim.SetModelClass("models/kw/vortigaunt_nobgslave.mdl", "vort")
ALWAYS_RAISED["swep_vortigaunt_sweep"] = true
ALWAYS_RAISED["swep_vortigaunt_heal"] = true
local CHAR = ix.meta.character
function CHAR:IsVortigaunt()
	local faction = self:GetFaction()
	return faction == FACTION_VORTIGAUNT or faction == FACTION_ENSLAVEDVORTIGAUNT
end
function PLUGIN:GetPlayerPainSound(client)
	if (client:GetCharacter():IsVortigaunt()) then
		local PainVort = {
			"vo/npc/vortigaunt/vortigese11.wav",
			"vo/npc/vortigaunt/vortigese07.wav",
			"vo/npc/vortigaunt/vortigese03.wav",
		}
		local vort_pain = table.Random(PainVort)
		return vort_pain
	end
end
function PLUGIN:GetPlayerDeathSound(client)
	if (client:GetCharacter():IsVortigaunt()) then
		return false
	end
end
if (CLIENT) then
	randomVortWords = {"ahglah", "ahhhr", "alla", "allu", "baah", "beh", "bim", "buu", "chaa", "chackt", "churr", "dan", "darr", "dee", "eeya", "ge", "ga", "gaharra",
"gaka", "galih", "gallalam", "gerr", "gog", "gram", "gu", "gunn", "gurrah", "ha", "hallam", "harra", "hen", "hi", "jah", "jurr", "kallah", "keh", "kih",
"kurr", "lalli", "llam", "lih", "ley", "lillmah", "lurh", "mah", "min", "nach", "nahh", "neh", "nohaa", "nuy", "raa", "ruhh", "rum", "saa", "seh", "sennah",
"shaa", "shuu", "surr", "taa", "tan", "tsah", "turr", "uhn", "ula", "vahh", "vech", "veh", "vin", "voo", "vouch", "vurr", "xkah", "xih", "zurr"}
end
ix.chat.Register("Vortigese", {
	format = "%s says in vortigese \"%s\"",
	GetColor = function(self, speaker, text)
		-- If you are looking at the speaker, make it greener to easier identify who is talking.
		if (LocalPlayer():GetEyeTrace().Entity == speaker) then
			return ix.config.Get("chatListenColor")
		end
		-- Otherwise, use the normal chat color.
		return ix.config.Get("chatColor")
	end,
	CanHear = ix.config.Get("chatRange", 280),
	CanSay = function(self, speaker,text)
		if (speaker:GetCharacter():IsVortigaunt()) then
			return true
		else
			speaker:NotifyLocalized("You don't know Vortigese!")
			return false
		end
	end,
	OnChatAdd = function(self,speaker, text, anonymous, info)
		local color = self:GetColor(speaker, text, info)
		local name = anonymous and
				L"someone" or hook.Run("GetCharacterName", speaker, chatType) or
				(IsValid(speaker) and speaker:Name() or "Console")
		
		if (!LocalPlayer():GetCharacter():IsVortigaunt()) then
			local splitedText = string.Split(text, " ")
			local vortigese = {}
			for k, v in pairs(splitedText) do
				local word = table.Random(randomVortWords)
				table.insert( vortigese, word )
			end
			PrintTable(vortigese)
			text = table.concat( vortigese, " " )
		end
		chat.AddText(color, string.format(self.format, name, text))
	end,	
	prefix = {"/v", "/vort"},
	description = "Speak in Vortigese",
	indicator = "Typing",
	deadCanChat = false
})
