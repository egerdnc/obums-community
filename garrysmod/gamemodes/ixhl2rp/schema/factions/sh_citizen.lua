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
	-- ## MALE MODELS ^^ ## --
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
	--initCitizenData(character)
	
	inventory:Add("suitcase", 1)
	inventory:Add("flashlight", 1)
	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})
end

function FACTION:OnTransferred(character)
	local client = character:GetPlayer()
	setCharacterCitizen(character, client)
end

function FACTION:OnSpawn(client)
	local character = client:GetCharacter()
	setCharacterCitizen(character, client)
end

function setCharacterCitizen(character, client)
	local model = character:GetData("citizen-model")
	local name = character:GetData("citizen-name")
	local bodygroup = character:GetData("citizen-bodygroup")
	
	character:SetFaction(3)
	character:SetModel(model)
	character:SetName(name)
	if bodygroup ~= nil or bodygroup ~= {} or bodygroup ~= "" then
		client:SetBodyGroups(bodygroup)
	end
end

FACTION_CITIZEN = FACTION.index
