AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/lockers001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end
end

function ENT:Use(activator)
    if not activator:IsPlayer() then return end

    local character = activator:GetCharacter()
    if not character then return end

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
        bank:Sync(activator)

        character:SetData("storageID", bank:GetID())
    end

    ix.storage.Open(activator, bank, {
        entity = self,
        name = "Bank Account",
        searchText = "Accessing bank account...",
        searchTime = 0
    })
    return
end