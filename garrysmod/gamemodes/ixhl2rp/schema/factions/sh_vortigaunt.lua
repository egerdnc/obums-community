VORTIGAUNT_MODEL = "models/vortigaunt.mdl"
FACTION.name = "Vortigaunt"
FACTION.description = ""
FACTION.color = Color(0, 150, 0)
FACTION.models = {"models/vortigaunt.mdl"}
FACTION.weapons = {"swep_vortigaunt_beam_edit", "swep_vortigaunt_heal"}
FACTION.isDefault = false
FACTION.isGloballyRecognized = false
FACTION.runSounds = {[0] = "npc/vort/vort_foot1.wav", [1] = "npc/vort/vort_foot2.wav"}

-- Hooked faction functions below there

function FACTION:OnSpawn(client)
	local character = client:GetCharacter()

	initVortigaunt(character)
end

function FACTION:OnTransferred(character)
	initVortigaunt(character)
end

function initVortigaunt(ply)
	ply:SetModel(VORTIGAUNT_MODEL)
end

FACTION_VORTIGAUNT = FACTION.index