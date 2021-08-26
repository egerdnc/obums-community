AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Riot Control Stun-stick"
SWEP.Category = "Longsword Beta Pack"
SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.HoldType = "melee"

SWEP.WorldModel = Model("models/weapons/w_stunbaton.mdl")
SWEP.ViewModel = Model("models/weapons/c_stunstick.mdl")
SWEP.ViewModelFOV = 52

SWEP.Slot = 0
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("weapons/stunstick/stunstick_swing1.wav")
SWEP.Primary.ImpactSound = Sound("weapons/stunstick/stunstick_impact2.wav")
SWEP.Primary.ImpactEffect = "StunstickImpact"
SWEP.Primary.FlashTime = 4
SWEP.Primary.Recoil = 1.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 4 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.7
SWEP.Primary.Range = 75

SWEP.Attachments = {
	riot_shield = {
		Cosmetic = {
			Model = "models/cloud/ballisticshield_mod.mdl",
			PlayerParent = true,
			Bone = "ValveBiped.Bip01_L_Hand",
			Pos = Vector(-14.3, -2, 20),
			Ang = Angle(80, 0, 0),
			Scale = 0.85,
			Skin = 0,
			World = {
				Bone = "ValveBiped.Bip01_L_Hand",
				Pos = Vector(-3, 2, 0),
				Ang = Angle(-25, 90, 0),
				Scale = 0.85
			}
		},
		ModSetup = function(e)
		end,
		ModCleanup = function(e)
		end
	}
}

-- based on NS sunstick effects:

local STUNSTICK_GLOW_MATERIAL = Material("effects/stunstick")
local STUNSTICK_GLOW_MATERIAL2 = Material("effects/blueflare1")
local STUNSTICK_GLOW_MATERIAL_NOZ = Material("sprites/light_glow02_add_noz")

local color_glow = Color(128, 128, 128)

function SWEP:ExtraDrawWorldModel()
	self:DrawModel()

	local size

	size = math.Rand(4.0, 6.0)

	local glow = math.Rand(0.6, 0.8) * 255
	local color = Color(glow, glow, glow)
	local attachment = self:GetAttachment(1)

	if (attachment) then
		local position = attachment.Pos

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL2)
		render.DrawSprite(position, size * 2, size * 2, color)

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL)
		render.DrawSprite(position, size, size + 3, color_glow)
	end
end

local NUM_BEAM_ATTACHEMENTS = 9
local BEAM_ATTACH_CORE_NAME	= "sparkrear"

function SWEP:PostDrawViewModel()

	local vm = LocalPlayer():GetViewModel()

	if not IsValid(vm) then
		return
	end

	cam.Start3D(EyePos(), EyeAngles())
		local size
		size = math.Rand(3.0, 4.0)

		local color = Color(255, 255, 255, 50 + math.sin(RealTime() * 2)*20)

		STUNSTICK_GLOW_MATERIAL_NOZ:SetFloat("$alpha", color.a / 255)

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL_NOZ)

		local attachment = vm:GetAttachment(vm:LookupAttachment(BEAM_ATTACH_CORE_NAME))

		if (attachment) then
			render.DrawSprite(attachment.Pos, size * 10, size * 15, color)
		end

		for i = 1, NUM_BEAM_ATTACHEMENTS do
			local attachment = vm:GetAttachment(vm:LookupAttachment("spark"..i.."a"))

			size = math.Rand(2.5, 5.0)

			if (attachment and attachment.Pos) then
				render.DrawSprite(attachment.Pos, size, size, color)
			end

			local attachment = vm:GetAttachment(vm:LookupAttachment("spark"..i.."b"))

			size = math.Rand(2.5, 5.0)

			if (attachment and attachment.Pos) then
				render.DrawSprite(attachment.Pos, size, size, color)
			end
		end
	cam.End3D()
end

