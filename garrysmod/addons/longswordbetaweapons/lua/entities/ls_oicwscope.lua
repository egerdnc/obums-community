AddCSLuaFile()


ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "OICW Scope"
ENT.Category = "Longsword Beta Attatchments"
ENT.Spawnable = true

function ENT:Initialize()
	self:SetModel( "models/items/item_item_crate.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then 
        phys:Wake()
    end
end

function ENT:Use(ply)
    if ( IsValid(ply) ) then
        local wep = ply:GetActiveWeapon()
        if ( IsValid(wep) ) then
            if ( wep.ClassName == "ls_oicw" ) then
                wep:GiveAttachment("oicw_scope")
                self:Remove()
            end
        end
    end
end