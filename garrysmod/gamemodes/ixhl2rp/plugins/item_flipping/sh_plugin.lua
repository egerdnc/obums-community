PLUGIN.name = 'Item Flipping [BETA]'
PLUGIN.author = 'TomSL / ZeMysticalTaco'
PLUGIN.description = 'Adds a function to all items not of identical proportions that allows them to be flipped horizontally, this plugin is in beta, and may have bugs associated with it.'
PLUGIN.autoGenerateFlippedItems = true --TURN THIS OFF IF YOU DON'T WANT ITEMS TO AUTOMATICALLY GENERATE FLIPPED VERSIONS!
ix.util.Include( 'sh_lang.lua' )
ix.util.Include('cl_overrides.lua')



function PLUGIN:GenerateFlippedItem( itemTable )
    --                                      uniqueID                            base     isBaseItem, n/a, luaGenerated
    local oldItem = ix.item.list[ itemTable ]
    local newItem = table.Copy( oldItem )
    newItem.width = oldItem.height
    newItem.height = oldItem.width
    newItem.uniqueID = oldItem.uniqueID .. '_flipped'
    ix.item.list[ oldItem.uniqueID .. '_flipped' ] = newItem

    oldItem.functions.Rotate = {
        name = 'rotateItem',
        description = 'Rotate this item 90 degrees.',
        icon = 'icon16/arrow_refresh.png',
        OnRun = function( item )
            local ply = item.player
            --local char = ply:GetCharacter()
            local inv = ix.item.inventories[ item.invID ]
            --FindEmptySlot is basically the "will it blend?" of inventory mechanics
            local x, y, bagInv = inv:FindEmptySlot( item.height, item.width )

            if ( bagInv ) then
                inv = bagInv
            end

            if ( not x or not y ) then
                --notify them how much space they need
                ply:NotifyLocalized( 'rotateNotAllowed', item.height, item.width )

                return false
            end

            inv:Add( item.uniqueID .. '_flipped', 1, item.data, x, y )
        end,
        --PrintTable(item:GetData())
        OnCanRun = function( item )
            if item.base and item.base == 'base_bags' then return false end
            if not item.invID then return false end
            if item.invID and item.invID == 0 then return false end
            if item:GetData( 'equip', false ) then return false end
        end
    }

    newItem.functions.Rotate = {
        name = 'rotateItem',
        description = 'Rotate this item 90 degrees.',
        icon = 'icon16/arrow_refresh.png',
        OnRun = function( item )
            local ply = item.player
            --local char = ply:GetCharacter()
            local inv = ix.item.inventories[ item.invID ] --FindEmptySlot is basically the "will it blend?" of inventory mechanics
            local x, y, bagInv = inv:FindEmptySlot( item.height, item.width )

            if ( bagInv ) then
                inv = bagInv
            end

            if ( not x or not y ) then
                --notify them how much space they need
                ply:NotifyLocalized( 'rotateNotAllowed', item.height, item.width )

                return false
            end

            inv:Add( oldItem.uniqueID, 1, item.data, x, y )
        end,
        OnCanRun = function( item )
            --at a certain point, a one line return statement just becomes unreadable.
            if item.base and item.base == 'base_bags' then return false end
            if not item.invID then return false end
            if item.invID and item.invID == 0 then return false end
            if item:GetData( 'equip', false ) then return false end
        end
    }
    
end
ix.item.GenerateFlippedItem = PLUGIN.GenerateFlippedItem


if PLUGIN.autoGenerateFlippedItems then
    local itemList = ix.item.list

    for k, v in pairs( itemList ) do
        if v.bNoGenerateFlippedItem then continue end --some people may not want certain items to flip.
        if string.find( k, '_flipped' ) then continue end --iirc ix.item.list regenerates every refresh, but this is a failsafe.
        if v.width == v.height then continue end
        PLUGIN:GenerateFlippedItem( k )
    end
end

if ix.InventoryExtensions then
    local function rotateMonitor(player, key)
        if ix.inventoryExtensions.SelectedItem then
            ix.inventoryExtensions.SelectedItem.rotated = not ix.inventoryExtensions.SelectedItem.rotated
        end
    end
    hook.Add('KeyPress', 'inventoryTweaks.item_flipping.rotateHotkey', rotateMonitor)
end
