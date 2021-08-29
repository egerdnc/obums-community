
if (CLIENT) then
	SWEP.PrintName        	= "Breaching Charge"			   
	SWEP.Slot				= 3  
	SWEP.SlotPos			= 1    
	SWEP.DrawCrosshair		= true
	SWEP.DrawAmmo    		= true

end

SWEP.Author					= "Chewitdude"
SWEP.Instructions	 	    = "Use on a door to blow it open!"
SWEP.Spawnable				= true
SWEP.ViewModel				= "models/weapons/c_slam.mdl"
SWEP.WorldModel				= "models/weapons/w_slam.mdl"
SWEP.Weight					= 5   
SWEP.AutoSwitchTo			= false   
SWEP.AutoSwitchFrom			= false  
SWEP.HoldType 				= "slam"
SWEP.UseHands 				= true
SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "slam"
SWEP.Primary.Delay			= 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "" 

if (SERVER) then
	if (file.Exists( "breachingcharge.txt", "DATA" )) then
		respawnTime = tonumber( file.Read( "breachingcharge.txt", "DATA" ) , 10)
	else
	file.Write( "breachingcharge.txt", 280 )
		respawnTime = 280
	end
end

concommand.Add( "breach_settime", function( ply, cmd, args )
		
		
		
		if !(args[1] == nil) then
			if !(tonumber(args[1]) == nil) then
			time = util.StringToType(args[1], "int")
			else return
			end
		else return
		end
	
		if (ply:IsAdmin()) then
			respawnTime = time
			print( "Door respawn time set to "..respawnTime)
			if SERVER then
				file.Write( "breachingcharge.txt", respawnTime )
			end
		else
			print( "You must be Administrator to use this command.")
		end
	
end )


function SWEP:Deploy()
	self:Reload()
    self:SendWeaponAnim( ACT_SLAM_THROW_ND_DRAW )
    return true
	
end



function SWEP:Initialize( )

self:SetWeaponHoldType( self.HoldType )	

	
end


function SWEP:Think()
	if ( self.Weapon:Clip1() <= 0 ) and (self:Ammo1(self.Primary.Ammo) <= 0) then
		self:SendWeaponAnim(ACT_SLAM_THROW_ND_DRAW )
	end
end


function SWEP:PrimaryAttack( )

	local tr = self.Owner:GetEyeTrace( )
	local ply = self.Owner
	
	if ( self.Weapon:Clip1() > 0 ) then 
		

		if ( tr.Entity:GetClass( ) == "prop_door_rotating" && tr.Entity:GetPos( ):Distance( self.Owner:GetPos( ) ) < 100 ) and tr.Entity.hascharge == nil then
			self.Weapon:SendWeaponAnim(ACT_SLAM_THROW_THROW_ND )
			self:TakePrimaryAmmo( 1 )
			self:Reload()

			timer.Create( "AnimReset", .6, 1, function() if IsValid(self.Weapon) then self.Weapon:SendWeaponAnim(ACT_SLAM_THROW_ND_IDLE) end end)
			tr.Entity:EmitSound( "npc/turret_floor/deploy.wav" )
		
			
			
		
		
			if ( SERVER ) then
		
				local origindirection = self.Owner:GetForward( )
		
				local ent = ents.Create( "prop_dynamic_override" )
				tr.Entity.hascharge = true
			 		
				ent:SetModel( "models/weapons/w_slam.mdl" ) 
			
				ent:SetParent( tr.Entity )
			

				ent:SetPos(tr.HitPos)
					
			
				if (tostring(ent:GetLocalPos().x) > "0") then
					ent:SetLocalPos(ent:GetLocalPos() + Vector(1.5,0,0))
				end
			
					if (tostring(ent:GetLocalPos().x) < "0") then
						ent:SetLocalPos(ent:GetLocalPos() + Vector(-1.5,0,0))
					end
							
						if (tostring(ent:GetLocalPos().x) > "0") then
							ent:SetAngles( tr.Entity:GetAngles() + Angle(-270,0,0))
						end
			
							if (tostring(ent:GetLocalPos().x) < "0") then
								ent:SetAngles( tr.Entity:GetAngles() + Angle(270,0,0))
							end
			
			
			
			ent:SetMoveType( MOVETYPE_NONE )
			ent:SetSolid( SOLID_VPHYSICS )
			ent:Spawn( ) 
			
				if ( self.Weapon:Clip1() <= 0 ) and (self:Ammo1(self.Primary.Ammo) <= 0) then
					self.Owner:StripWeapon("breachingcharge")
				end	
			
				timer.Simple(0.25, function( )if IsValid(ent) then ent:EmitSound( "ui/beep07.wav" ) end end )
				timer.Simple(0.5, function( )if IsValid(ent) then ent:EmitSound( "ui/beep07.wav" ) end end ) 
				timer.Simple(0.75, function( )if IsValid(ent) then ent:EmitSound( "ui/beep07.wav" ) end end )
				timer.Simple(2, function( )if IsValid(ent) then ent:EmitSound( "ui/arm_bomb.wav" ) end end )
				timer.Simple(3.05, function( )if IsValid(ent) then ent:EmitSound( "ui/arm_bomb.wav" ) end end )
				timer.Simple(4, function( ) 
				
				
			tr.Entity:SetNotSolid(true)
			tr.Entity:SetNoDraw(true)
			
			
						local door = ents.Create( "prop_physics" )
					if IsValid(door) and IsValid(tr.Entity) then
						door:SetModel( tr.Entity:GetModel( ) )
			
						door:SetPos( tr.Entity:GetPos( ) )
						door:SetAngles( tr.Entity:GetAngles( ) )
				
						door:SetSkin( tr.Entity:GetSkin( ) )
			
						door:Spawn( ) 
							if self:IsValid() then
								door:GetPhysicsObject( ):SetVelocity( self.Owner:GetPos( ) + origindirection * 10000 )
								else
								door:GetPhysicsObject( ):SetVelocity( origindirection * 10000 )
							end
					
					
						local explode = ents.Create( "env_explosion" )
			
						explode:SetKeyValue( "spawnflags", 128 )
						explode:SetPos( tr.Entity:GetPos( ) )
					
						explode:Spawn( )
				
						explode:Fire( "explode", "", 0 )
				
						ent:Remove( )
						tr.Entity.hascharge = nil					
					
						timer.Simple(respawnTime, function()
						tr.Entity:SetNotSolid(false)
						tr.Entity:SetNoDraw(false)
					
							if door && IsValid(door) then
								door:Remove()
								door = nil
							end
							
						end)
					
					end
				end )
			
			end
		else return end 
	else return	
	end
	
end


function SWEP:SecondaryAttack( )
end 

function SWEP:Holster( )
return true	
end
