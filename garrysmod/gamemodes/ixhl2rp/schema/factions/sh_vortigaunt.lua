
FACTION.name = "Vortigaunt"
FACTION.description = ""
FACTION.color = Color(0, 150, 0)
FACTION.models = {"models/vortigaunt.mdl"}
FACTION.weapons = {"swep_vortigaunt_beam_edit", "swep_vortigaunt_heal"}
FACTION.isDefault = false
FACTION.isGloballyRecognized = false
FACTION.runSounds = {[0] = "npc/vort/vort_foot1.wav", [1] = "npc/vort/vort_foot2.wav"}

function FACTION:OnTransfered(client)
	local character = client:GetCharacter()

	character:SetModel(self.models[1])
end

FACTION_VORTIGAUNT = FACTION.index