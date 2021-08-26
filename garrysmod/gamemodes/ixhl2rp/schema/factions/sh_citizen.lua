
FACTION.name = "Citizens"
FACTION.description = "You are a normal citizen oppressed by the combine"
FACTION.color = Color(150, 125, 100, 255)
FACTION.pay = 5
FACTION.models = {
	"models/player/zelpa/male_01.mdl",
	"models/player/zelpa/male_02.mdl",
	"models/player/zelpa/male_03.mdl",
	"models/player/zelpa/male_04.mdl",
	"models/player/zelpa/male_05.mdl",
	"models/player/zelpa/male_06.mdl",
	"models/player/zelpa/male_07.mdl",
	"models/player/zelpa/male_08.mdl",
	"models/player/zelpa/male_09.mdl",
	"models/player/zelpa/male_10.mdl",
	"models/player/zelpa/male_11.mdl",
	-- ## MALE MODELS ## --
	"models/player/zelpa/female_01.mdl",
	"models/player/zelpa/female_02.mdl",
	"models/player/zelpa/female_03.mdl",
	"models/player/zelpa/female_04.mdl",
	-- "models/player/zelpa/female_05.mdl",
	"models/player/zelpa/female_06.mdl",
	"models/player/zelpa/female_07.mdl"
}

FACTION.isDefault = true
function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)
	character:SetData("citizen-model", character:GetModel())

	inventory:Add("suitcase", 1)
	inventory:Add("flashlight", 1)
	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})
end

function FACTION:OnTransfered(character)
	initCitizen(character)
end

function FACTION:OnSpawn(client)
	local character = client:GetCharacter()

	initCitizen(character)
end

function FACTION:OnTransferred(character)
	initCitizen(character)
end

function initCitizen(char)
	local model = char:getData("citizen-model")
	char:SetModel(model)
end

FACTION_CITIZEN = FACTION.index
