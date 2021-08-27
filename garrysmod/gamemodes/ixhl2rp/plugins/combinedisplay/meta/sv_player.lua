
local playerMeta = FindMetaTable("Player")

function playerMeta:AddCombineDisplayMessage(text, color, time, ...)
	if (self:IsCombine()) then
		color = color or color_white
		time = time or 8

		net.Start("CombineDisplayMessage")
			net.WriteString(text)
			net.WriteColor(color)
			net.WriteUInt(time, 8)
			net.WriteTable({...})
		net.Send(self)
	end
end
