AddCSLuaFile()

SWEP.Base = "ls_base_shotgun"

SWEP.PrintName = "SPAS-12"
SWEP.Category = "Longsword Beta Pack"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"

SWEP.WorldModel = Model("models/weapons/w_shotgun.mdl")
SWEP.ViewModel = Model("models/weapons/tfa_ins2/c_spas12_bri.mdl")
SWEP.ViewModelFOV = 40

SWEP.Slot = 3
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("Weapon_Shotty.Single")
SWEP.Primary.Recoil = 8 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 20
SWEP.Primary.PenetrationScale = 1
SWEP.Primary.NumShots = 6
SWEP.Primary.Burst = false
SWEP.Primary.Cone = 0.18
SWEP.Primary.Delay = RPM(45)

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.6
SWEP.Spread.IronsightsMod = 0.85 -- multiply
SWEP.Spread.CrouchMod = 0.45 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.04 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.07 -- movement speed effect on spread (additonal)

SWEP.NoIronsights = false

SWEP.IronSightsPos = Vector(-2.6, 3.015, 0.839)
SWEP.IronsightsAng = Vector(0, 0, 0)
SWEP.IronsightsFOV = 0.9
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false

SWEP.LoweredPos = Vector(3.819, -2.412, 1.205)
SWEP.LoweredAng = Vector(-19.698, 23.215, 0)


sound.Add({
	name = "Weapon_Shotty.Single",
	sound = "shotty/shotgun_fire7.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
}) 
sound.Add({
	name = "TFA_INS2_SPAS12.LeanIn",
	sound = "weapons/tfa_ins2/spas12/pumpback.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "TFA_INS2_SPAS12.ShellInsert",
	sound = "shotty/shotgun_reload2.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 115}
}) 

