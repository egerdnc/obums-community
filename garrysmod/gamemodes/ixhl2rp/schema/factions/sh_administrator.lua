
FACTION.name = "Administrator"
FACTION.description = "A Homo Sapien Administrator used as a puppet for the Universal Union."
FACTION.color = Color(255, 200, 100, 255)
FACTION.pay = 50
FACTION.models = {
	"models/humans/group17/female_01.mdl",
	"models/humans/group17/female_02.mdl",
	"models/humans/group17/female_03.mdl",
	"models/humans/group17/female_04.mdl",
	"models/humans/group17/female_06.mdl",
	"models/humans/group17/female_07.mdl",
	"models/humans/group17/male_01.mdl",
	"models/humans/group17/male_02.mdl",
	"models/humans/group17/male_03.mdl",
	"models/humans/group17/male_04.mdl",
	"models/humans/group17/male_05.mdl",
	"models/humans/group17/male_06.mdl",
	"models/humans/group17/male_07.mdl",
	"models/humans/group17/male_08.mdl",
	"models/humans/group17/male_09.mdl"
}
FACTION.isDefault = false
FACTION.isGloballyRecognized = true

function FACTION:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("pistol", 1)
	inventory:Add("pistolammo", 2)

	inventory:Add("flashlight", 1)
end


FACTION_ADMIN = FACTION.index
