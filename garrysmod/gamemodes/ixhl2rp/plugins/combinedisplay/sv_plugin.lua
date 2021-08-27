
local PLUGIN = PLUGIN

util.AddNetworkString("CombineDisplayMessage")

function PLUGIN:AddCombineDisplayMessage(text, color, time, exclude, ...)
	color = color or color_white
	time = time or 8

	local arguments = {...}
	local receivers = {}

	-- we assume that exclude will be part of the argument list if we're using
	-- a phrase and exclude is a non-player argument
	if (type(exclude) != "Player") then
		table.insert(arguments, 1, exclude)
	end

	for _, v in ipairs(player.GetAll()) do
		if (v:IsCombine() and v != exclude) then
			receivers[#receivers + 1] = v
		end
	end

	net.Start("CombineDisplayMessage")
		net.WriteString(text)
		net.WriteColor(color)
		net.WriteUInt(time, 8)
		net.WriteTable(arguments)
	net.Send(receivers)
end
