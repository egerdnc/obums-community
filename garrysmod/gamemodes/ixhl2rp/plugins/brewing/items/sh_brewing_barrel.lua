--[[---------------------------------------------------------------------------
	** Copyright (c) 2021 Connor ---- (ZIKE)
	** This file is private and may not be shared, downloaded, used, sold or even copied.
---------------------------------------------------------------------------]]--

-- Item Statistics

-- ITEM.name = "Brewing Barrel"
-- ITEM.description = "A Brewing Barrel which can be placed permanently on a surface."
-- ITEM.category = "Brewing"

-- ITEM.model = "models/props/de_inferno/wine_barrel_static.mdl"
-- ITEM.skin = 0

-- ITEM.width = 2
-- ITEM.height = 4

-- ITEM.price = 100

-- -- Item Statistics (Custom)

-- ITEM.noBusiness = true

-- -- Item Functions

-- ITEM.functions.Place = {
-- 	icon = "icon16/box.png",
-- 	OnRun = function(itemstat)
-- 		local client = itemstat.player
-- 		local character = client:GetCharacter()

-- 		client:EmitSound("physics/metal/metal_barrel_impact_hard"..math.random(1,7)..".wav", 80)
		
--         	local brewingbarrel = ents.Create("ix_brewbarrel")
--        		brewingbarrel:SetPos(client:EyePos() + (client:GetAimVector() * 50))
--         	brewingbarrel:Spawn()
-- 	end
-- }
