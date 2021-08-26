AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "Overwatch Sniper Rifle"
SWEP.Category = "Longsword Beta Pack"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/w_combinesniper_e2.mdl")
SWEP.ViewModel = Model("models/weapons/combine_sniper_weapon.mdl")
SWEP.ViewModelFOV = 70

SWEP.Slot = 4
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound = Sound("Weapon_CSNIPER.Single")
SWEP.Primary.Recoil = 3 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 90
SWEP.Primary.PenetrationScale = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.Burst = false
SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = RPM(27)

SWEP.ViewModelBoneMods = {
	["body"] = { scale = Vector(1, 1, 1), pos = Vector(-5.37, -2.037, 0), angle = Angle(0, 0, 0) }
}


SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.01
SWEP.Spread.IronsightsMod = 0.02 -- multiply
SWEP.Spread.CrouchMod = 0.94 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.04 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.07 -- movement speed effect on spread (additonal)

SWEP.NoIronsights = false

SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronsightsAng = Vector(0, 0, 0)
SWEP.IronsightsFOV = 0.05
SWEP.IronsightsSensitivity = 0.1
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1


SWEP.Attachments = {
	osr_scope = {
		Cosmetic = {
			Model = "models/weapons/c_ar2_nope.mdl",
			Bone = "Base",
			Pos = Vector(0, 0, 0),
			Ang = Angle(0, 0, 0),
			Scale = 0,
			Skin = 0
		},
		ModSetup = function(e)
			e.IronsightsFOV = 0.1
			e.FOVScoped = 0.1
			e.Spread.IronsightsMod = 0.02
			e.IronsightsCrosshair = false
			e.IronsightsSensitivity = 0.1
			e.Spread.VelocityMod = 1.1

		end,
		ModCleanup = function(e)
			e.IronsightsFOV = copyIronFOV
			e.IronsightsSensitivity = copyIronSens
			e.Spread.VelocityMod = copySpreadVel
			e.IronsightsCrosshair = false
			e.FOVScoped = nil
			e.Spread.IronsightsMod = nil

		end,
		NeedsHDR = true,
		Behaviour = "sniper_sight",
		ScopePaint = function(wep)
			if not OSR_OVERLAY then
		        OSR_OVERLAY = Material("effects/combine_binocoverlay")
		        OSR_OVERLAY:SetFloat("$salpha", "0.2")
		        OSR_OVERLAY:Recompute()
			end

			surface.SetDrawColor(Color(255, 255, 255, 255))
	        surface.SetMaterial(OSR_OVERLAY)
	        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		end,
		ScopeTexture = Material("ph_scope/ph_scope_lens3")
	}
}

sound.Add({
	name = "Weapon_CSNIPER.Single",
	sound = "sniper/shot.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_180dB,
	pitch = {95, 105}
}) 
sound.Add({
	name = "clipout_com",
	sound = "sniper/magout.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "clipin_com",
	sound = "sniper/magin.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "boltpull_com",
	sound = "sniper/boltback.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "deploy_com",
	sound = "sniper/foley.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 

