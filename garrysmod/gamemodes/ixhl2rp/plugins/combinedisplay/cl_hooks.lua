
local PLUGIN = PLUGIN

function PLUGIN:CharacterLoaded(character)
	if (character:IsCombine()) then
		vgui.Create("ixCombineDisplay")
	elseif (IsValid(ix.gui.combine)) then
		ix.gui.combine:Remove()
	end
end

function PLUGIN:Tick()
	if (IsValid(LocalPlayer()) and LocalPlayer():Alive() and LocalPlayer():IsCombine()) then
		if (!self.nextRandomLine or CurTime() >= self.nextRandomLine) then
			local index = math.random(1, #self.randomDisplayLines)

			local text = self.randomDisplayLines[index]

			if (istable(text)) then
				text = text[2](text[1])
			end

			if (text and self.lastRandomDisplayLine != index) then
				self:AddCombineDisplayMessage(text)

				self.lastRandomDisplayLine = index
				self.nextRandomLine = CurTime() + 10
			end
		end
	end
end

net.Receive("CombineDisplayMessage", function()
	if (IsValid(ix.gui.combine)) then
		local text, color, time, arguments = net.ReadString(), net.ReadColor(), net.ReadUInt(8), net.ReadTable()

		ix.gui.combine:AddLine(text, color, time, unpack(arguments))
	end
end)
