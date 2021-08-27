
local PLUGIN = PLUGIN

PLUGIN.randomDisplayLines = {
	{"Pinging 127.0.0.1 with 32 bytes of data...", function(text)
		local ping = math.Rand(0,2)

		timer.Simple(ping/1000, function()
			PLUGIN:AddCombineDisplayMessage(Format("Reply: time %dms, sent = 4, lost = %d", ping, math.Rand(0,2)))
		end)

		return text
	end},
	{"Writing functionary datafile - '%s.dat'", function(text) return Format(text, ix.date.GetFormatted("%S%M%d%m%Y")) end},
	"Conditioning interal uniform temperature...",
	"Requesting locational vector data...",
	"Requesting new SSH server connection...",
	"Parsing view ports and data arrays...",
	"Serializing outbound data queue...",
	"Decrypting inbound data stream...",
	"Parsing waypoint vector data...",
	"Pinging connection to network...",
	"Translating combine practicalities...",
	"Requesting current squad manifest...",
	"Connection to secure network active...",
	"Syncing additional sector waypoints...",
	"Naturalizing citizen manifest...",
	"Binding incoming data stream...",
	"Locating additional units...",
	"Logging current conditions...",
	"Tracking incoming objectives...",
	"Caching local metrics data..."
}

function PLUGIN:AddCombineDisplayMessage(text, color, time, ...)
	if (LocalPlayer():IsCombine() and IsValid(ix.gui.combine)) then
		ix.gui.combine:AddLine(text, color, time, ...)
	end
end
