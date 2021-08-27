AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "MP5k"
SWEP.Category = "Longsword Beta Pack"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "smg"

SWEP.WorldModel = Model("models/weapons/w_smg2.mdl")
SWEP.ViewModel = Model("models/weapons/tfa_ins2/c_mp5k.mdl")
SWEP.ViewModelFOV = 70

SWEP.Slot = 2
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("Weapon_MP5K.Single")
SWEP.Primary.Recoil = 0.15 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 7
SWEP.Primary.PenetrationScale = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.Burst = false
SWEP.Primary.Cone = 0.025
SWEP.Primary.Delay = RPM(610)

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 25

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.2
SWEP.Spread.IronsightsMod = 0.55 -- multiply
SWEP.Spread.CrouchMod = 0.98 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.04 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.07 -- movement speed effect on spread (additonal)

SWEP.NoIronsights = false

SWEP.IronsightsPos = Vector(-0.08, 0, -4.35)
SWEP.IronsightsAng = Angle(0.703, 0, 0)
SWEP.IronsightsFOV = 0.75
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = true
SWEP.IronsightsRecoilVisualMultiplier = 0.9
 

sound.Add({
	name = "Weapon_MP5K.Single",
	sound = "mp5k/smg2_fire1.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
}) 
sound.Add({
	name = "TFA_INS2.MP5K.MagRelease",
	sound = "weapons/tfa_ins2/mp5k/mp5k_magrelease.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "TFA_INS2.MP5K.Magout",
	sound = "weapons/tfa_ins2/mp5k/mp5k_magout.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "TFA_INS2.MP5K.Magin",
	sound = "weapons/tfa_ins2/mp5k/mp5k_magin.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 

