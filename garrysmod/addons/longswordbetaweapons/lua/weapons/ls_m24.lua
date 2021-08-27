AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "M24"
SWEP.Category = "Longsword Beta Pack"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/smc/m24/w_m24.mdl")
SWEP.ViewModel = Model("models/weapons/smc/m24/c_m24.mdl")
SWEP.ViewModelFOV = 60

SWEP.Slot = 4
SWEP.SlotPos = 2

SWEP.CSMuzzleFlashes = true

SWEP.Primary.Sound = Sound("Weapon_REBSNIPER.Single")
SWEP.Primary.Recoil = 3 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 80
SWEP.Primary.PenetrationScale = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.Burst = false
SWEP.Primary.Cone = 0.09
SWEP.Primary.Delay = RPM(52)

SWEP.ViewModelBoneMods = {
	["b_root"] = { scale = Vector(1, 1, 1), pos = Vector(9.444, -3.52, -3.149), angle = Angle(0, 0, 0) }
}
SWEP.WElements = {
	["m24"] = { type = "Model", model = "models/weapons/smc/m24/w_m24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 0.518, -0.519), angle = Angle(-10.52, -1.17, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}



SWEP.Primary.Ammo = "357"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.06
SWEP.Spread.IronsightsMod = 0.06 -- multiply
SWEP.Spread.CrouchMod = 0.2 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.04 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.07 -- movement speed effect on spread (additonal)

SWEP.NoIronsights = false

SWEP.IronsightsPos = Vector(-3.15, 0, 1.4)
SWEP.IronsightsAng = Angle(0.703, 0, 0)
SWEP.IronsightsFOV = 0.5
SWEP.IronsightsSensitivity = 0.1
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1

SWEP.Attachments = {
	m24_scope = {
		Cosmetic = {
			Model = "models/weapons/tfa_ins2/upgrades/w_scope_m40.mdl",
			Bone = "b_root",
			Pos = Vector(-3.6, 9, -4.12),
			Ang = Angle(0, -90, 0),
			Scale = 0.5,
			Skin = 0
		},
		ModSetup = function(e)
			e.IronsightsFOV = 0.4
			e.FOVScoped = 0.4
			e.Spread.IronsightsMod = 0.08
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
			if not M24_OVERLAY then
		        M24_OVERLAY = Material("combine_sniper/nothin")
		        M24_OVERLAY:SetFloat("$salpha", "0.2")
		        M24_OVERLAY:Recompute()
			end

			surface.SetDrawColor(Color(255, 255, 255, 255))
	        surface.SetMaterial(M24_OVERLAY)
	        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		end,
		ScopeTexture = Material("ph_scope/ph_scope_lens3")
	}
}

sound.Add({
	name = "Weapon_REBSNIPER.Single",
	sound = "weapons/m24sws/m24_shoot_default.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_180dB,
	pitch = {95, 105}
}) 
sound.Add({
	name = "TFA_INS2.M24SWS.Roundin",
	sound = "weapons/m24sws/m24_bulletin_4.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_180dB,
	pitch = {95, 105}
}) 
sound.Add({
	name = "TFA_INS2.M24SWS.Deploy",
	sound = "weapons/m24sws/m24_deploy.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_180dB,
	pitch = {100}
}) 

