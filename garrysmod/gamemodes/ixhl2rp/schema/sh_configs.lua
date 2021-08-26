
ix.currency.symbol = ""
ix.currency.singular = "Token"
ix.currency.plural = "Tokens"

ix.config.SetDefault("scoreboardRecognition", true)
ix.config.SetDefault("music", "music/hl2_song2.mp3")
ix.config.SetDefault("maxAttributes", 60)

ix.config.Add("rationTokens", 30, "The amount of tokens that a person will get from a ration", nil, {
	data = {min = 0, max = 1000},
	category = "economy"
})

ix.config.Add("rationInterval", 300, "How long a person needs to wait in seconds to get their next ration", nil, {
	data = {min = 0, max = 86400},
	category = "economy"
})
