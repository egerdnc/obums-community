AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "USP Match"
SWEP.Category = "Longsword Beta Pack"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "revolver"

SWEP.WorldModel = Model("models/weapons/w_pistol.mdl")
SWEP.ViewModel = Model("models/weapons/c_pistoledit.mdl")
SWEP.ViewModelFOV = 60

SWEP.Slot = 2
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = true

SWEP.ReloadSound = Sound("Weapon_USP.Reload")
SWEP.Primary.Sound = Sound("Weapon_USP.Single")
SWEP.Primary.Recoil = 1 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 9
SWEP.Primary.PenetrationScale = 1
SWEP.Primary.NumShots = 1
SWEP.Primary.Burst = false
SWEP.Primary.Cone = 0.02
SWEP.Primary.Delay = RPM(190)

SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 15
SWEP.Primary.DefaultClip = 15

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.05
SWEP.Spread.IronsightsMod = 0.4 -- multiply
SWEP.Spread.CrouchMod = 0.94 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.04 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.07 -- movement speed effect on spread (additonal)

SWEP.NoIronsights = false

SWEP.IronsightsPos = Vector(-5.961, -5.428, 3.16)
SWEP.IronsightsAng = Angle(0, -1.407, 0)
SWEP.IronsightsFOV = 0.6
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 0.9

sound.Add({
	name = "Weapon_USP.Single",
	sound = "usp/pistol_fire2.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
}) 
sound.Add({
	name = "Weapon_USP.Reload",
	sound = "weapons/pistol/pistol_reload1.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "TFA_INS2.USP_M.Magrelease",
	sound = "weapons/tfa_ins2/usp_match/usp_match_magrelease.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "TFA_INS2.USP_M.Magout",
	sound = "weapons/tfa_ins2/usp_match/usp_match_magout.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "TFA_INS2.USP_M.Magin",
	sound = "weapons/tfa_ins2/usp_match/usp_match_magin.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "TFA_INS2.USP_M.MagHit",
	sound = "weapons/tfa_ins2/usp_match/usp_match_maghit.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 

