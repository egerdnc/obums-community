if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if (CLIENT) then
	SWEP.Slot = 5;
	SWEP.SlotPos = 5;
	SWEP.DrawAmmo = false;
	SWEP.PrintName = "Heal Ability";
	SWEP.DrawCrosshair = true;
end

SWEP.Author					= "JohnyReaper"
SWEP.Instructions 			= "Primary Fire: Heal";
SWEP.Purpose 				= "To healing people.";
SWEP.Contact 				= ""

SWEP.Category				= "Vort Swep" 
SWEP.Slot					= 5
SWEP.SlotPos				= 5
SWEP.Weight					= 5
SWEP.Spawnable     			= true
SWEP.AdminSpawnable			= false;
-- SWEP.ViewModel 				= "models/weapons/v_vortbeamvm.mdl"
SWEP.WorldModel 			= ""
SWEP.HoldType 				= "heal"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()
	if (SERVER) then
		self.Owner:DrawViewModel(false)
	
		if (!self.HealSound) then
		self.HealSound = CreateSound( self.Weapon, "npc/vort/health_charge.wav" );
		end
	
	end

end

function SWEP:Holster()
	if (SERVER) then
		self.Owner:DrawViewModel(true)
	end

	return true
end


function SWEP:OnRemove()
	if (SERVER) then
		self.Owner:DrawViewModel(true)
	end

	return true
end

function SWEP:DispatchEffect(EFFECTSTR)
	local pPlayer=self.Owner;
	if !pPlayer then return end
	local view;
	if CLIENT then view=GetViewEntity() else view=pPlayer:GetViewEntity() end
		if ( !pPlayer:IsNPC() && view:IsPlayer() ) then
			ParticleEffectAttach( EFFECTSTR, PATTACH_POINT_FOLLOW, pPlayer, pPlayer:LookupAttachment( "leftclaw" ) );
		else
			ParticleEffectAttach( EFFECTSTR, PATTACH_POINT_FOLLOW, pPlayer, pPlayer:LookupAttachment( "leftclaw" ) );
		end
end


function SWEP:PrimaryAttack()
	
	if (!self.Owner:Alive()) then return false end
	if (!self.Owner:GetCharacter():IsVortigaunt()) then return false end

	-- self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local eye = self.Owner:GetEyeTrace()
	
	if eye.HitPos:Distance(self.Owner:GetShootPos()) > 70 then return end
	if (!eye.Entity:IsPlayer()) then return end
	if (SERVER) and self.Owner:Health() <= 50 then 
		self.Owner:NotifyLocalized("You are too weak to heal someone!")
		return end

	self:DispatchEffect("vortigaunt_charge_token")

	local target = eye.Entity
	if (SERVER) then
		
		if target:Health() >= target:GetMaxHealth() then return end

		self.Owner:ForceSequence("heal_cycle")

		self.Owner:EmitSound( "npc/vort/health_charge.wav", 100, 150, 1, CHAN_AUTO )

		
	end
	timer.Simple(2,function() 
		-- if IsValid(self.Owner:GetViewModel())then self.Owner:GetViewModel():StopParticles() end
		self.Owner:StopParticles()
		if SERVER then
			local randomNum = math.random(ix.config.Get("VortHealMin", 5),ix.config.Get("VortHealMax", 20))
			target:SetHealth(math.Clamp(target:Health()+randomNum, 0, target:GetMaxHealth()))
			self.Owner:StopSound("npc/vort/health_charge.wav") 
		end
	end)
	self:SetNextPrimaryFire( CurTime() + 3 )

end;


function SWEP:SecondaryAttack()
	return false
end