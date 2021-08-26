AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "MP7"
SWEP.Category = "Longsword Beta Pack"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "smg"

SWEP.WorldModel = Model("models/weapons/w_smg1.mdl")
SWEP.ViewModel = Model("models/weapons/c_smg1.mdl")
SWEP.ViewModelFOV = 55

SWEP.Slot = 2
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_MP7.Reload")
SWEP.Primary.Sound = Sound("Weapon_MP7.Single")
SWEP.Primary.Recoil = 0.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 5
SWEP.Primary.PenetrationScale = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.Burst = false
SWEP.Primary.Cone = 0.052
SWEP.Primary.Delay = RPM(900)

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 45
SWEP.Primary.DefaultClip = 45

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.2
SWEP.Spread.IronsightsMod = 0.9 -- multiply
SWEP.Spread.CrouchMod = 0.94 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.04 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.07 -- movement speed effect on spread (additonal)

SWEP.NoIronsights = false

SWEP.IronSightsPos = Vector(-6.433, -11.056, 1.004)
SWEP.IronsightsAng = Vector(0, 0, 0)
SWEP.IronsightsFOV = 0.75
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 4 

sound.Add({
	name = "Weapon_MP7.Single",
	sound = "mp7/smg1_fire1.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
}) 
sound.Add({
	name = "Weapon_MP7.Reload",
	sound = "weapons/smg1/smg1_reload.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 



