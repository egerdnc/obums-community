
local PLUGIN = PLUGIN

if (SERVER) then
	function Schema:AddCombineDisplayMessage(text, color, time, exclude, ...)
		PLUGIN:AddCombineDisplayMessage(text, color, time, exclude, ...)
	end
else
	function Schema:AddCombineDisplayMessage(text, color, time, ...)
		PLUGIN:AddCombineDisplayMessage(text, color, time, ...)
	end
end
