AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( self.model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

end
	
function ENT:Use( user )
	user:SetWalkSpeed( 160 )
	user:SetRunSpeed( 240 )
	self:Remove()
	user:ChatPrint("You have applied a splint to your leg!")
end
