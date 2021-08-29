if SERVER then

    function ENT:Initialize()
        if (CLIENT) then return end
        self:SetModel( "models/items/ammocrate_ar2.mdl" )
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        local phys = self:GetPhysicsObject()
        phys:Wake()
    end

    function ENT:Use(client)
        self:NextThink( CurTime() + 1 )
        if not client:IsCombine() then client:Notify("You need to be a combine unit to do this.") return end
        self:SetUseType(SIMPLE_USE)
        self:EmitSound("items/ammocrate_open.wav")
        self:SetSequence(1)
        self:EmitSound("items/ammo_pickup.wav")
            for i, v in pairs(client:GetWeapons()) do
                local weapon = v
                local ammoID = weapon:GetPrimaryAmmoType()
                client:SetAmmo(300, ammoID, false)
            end
        timer.Simple(.1, function()
            self:SetSequence(2)
            timer.Simple(.5, function()
                self:EmitSound("items/ammocrate_close.wav")
                self:SetSequence(0)
            end)
        end)
    end

end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end
