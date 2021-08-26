AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "OICW"
SWEP.Category = "Longsword Beta Pack"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/w_oicw.mdl")
SWEP.ViewModel = Model("models/weapons/c_ar2_nope.mdl")
SWEP.ViewModelFOV = 40

SWEP.Slot = 3
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_OICW.Reload")
SWEP.EmptySound = Sound("Weapon_OICW.Empty")

SWEP.Primary.Sound = Sound("Weapon_OICW.Single")
SWEP.Primary.Recoil = 0.6 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 10
SWEP.Primary.PenetrationScale = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.Burst = true
SWEP.Primary.BurstEndDelay = 0.3
SWEP.Primary.Cone = 0.015
SWEP.Primary.Delay = RPM(1050)

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.1
SWEP.Spread.IronsightsMod = 0.12 -- multiply
SWEP.Spread.CrouchMod = 0.94 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.04 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.07 -- movement speed effect on spread (additonal)

SWEP.IronSightsPos = Vector(-7.481, -20, 3)
SWEP.IronSightsAng = Angle(0, -46.432, 0)
SWEP.IronsightsFOV = 0.3
SWEP.IronsightsSensitivity = 0.4
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 2

local copyIronFOV = SWEP.IronsightsFOV + 0
local copyIronSens = SWEP.IronsightsSensitivity + 0
local copyIronMod = SWEP.Spread.IronsightsMod + 0
local copySpreadVel = SWEP.Spread.VelocityMod + 0
SWEP.Attachments = {
	oicw_scope = {
		Cosmetic = {
			Model = "models/weapons/c_ar2_nope.mdl",
			Bone = "Base",
			Pos = Vector(0, 0, 0),
			Ang = Angle(0, 0, 0),
			Scale = 0,
			Skin = 0
		},
		ModSetup = function(e)
			e.IronsightsFOV = 0.65
			e.FOVScoped = 0.3
			e.Spread.IronsightsMod = 0.4
			e.IronsightsCrosshair = false
			e.IronsightsSensitivity = 0.4
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
			if not CMB_OVERLAY then
		        CMB_OVERLAY = Material("effects/scope04")
		        CMB_OVERLAY:SetFloat("$salpha", "0.2")
		        CMB_OVERLAY:Recompute()
			end

			surface.SetDrawColor(Color(255, 255, 255, 255))
	        surface.SetMaterial(CMB_OVERLAY)
	        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		end,
		ScopeTexture = Material("effects/scope01")
	}
}

sound.Add({
	name = "Weapon_OICW.Single",
	sound = "oicw/fire1.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})
sound.Add({
	name = "Weapon_OICW.Reload",
	sound = "oicw/ar2_reload.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
}) 
sound.Add({
	name = "Weapon_OICW.Empty",
	sound = "oicw/ar2_empty.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {100}
})
