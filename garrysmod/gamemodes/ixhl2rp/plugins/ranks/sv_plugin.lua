local PLUGIN = PLUGIN

function PLUGIN:CharacterVarChanged(character, key, oldValue, value)
	local client = character:GetPlayer()
	if (key == "rank") then
		local factionTable = ix.faction.Get(client:Team())

		if (factionTable.OnRankChanged) then
			factionTable:OnRankChanged(client, oldValue, value)
		end
	end
end
