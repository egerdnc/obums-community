AddCSLuaFile()


ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Medium Ammo"
ENT.Category = "Longsword Beta Pack"
ENT.Spawnable = true

function ENT:Initialize()
	self:SetModel( "models/items/largeboxmrounds.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end
end

function ENT:PhysicsCollide(colData, phys)
	if colData and colData.HitEntity and IsValid(colData.HitEntity) then
		if colData.HitEntity:GetClass() ~= "player" then
			return
		end
		colData.HitEntity:GiveAmmo(30,"ar2")
        self:Remove()
	end
end