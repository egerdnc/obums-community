local PLUGIN = PLUGIN

function PLUGIN:OnCharacterCreated(client, character)
    local bank = ix.item.CreateInv(12, 12, os.time())
    bank:SetOwner(character:GetID())
    bank:Sync(client)

    character:SetData("storageID", bank:GetID())
end

function PLUGIN:PlayerLoadedCharacter(client, character, currentCharacter)
    local ID = character:GetData("storageID")
    local bank

    if ID then
        bank = ix.item.inventories[ID]

        if not bank then
            ix.item.RestoreInv(ID, 12, 12, function(inventory)
                inventory:SetOwner(character:GetID())
                bank = inventory
            end)
        end
    else
        bank = ix.item.CreateInv(12, 12, os.time())
        bank:SetOwner(character:GetID())
        bank:Sync(character)

        character:SetData("storageID", bank:GetID())
    end
end