local PLUGIN = PLUGIN

PLUGIN.name = "Unstuck"
PLUGIN.author = "Sydres#9887"
PLUGIN.description = "Unstucks you thats it, so simple right?"

unStuckCommand = {
    description = "Tries to get you unstuck.",
    OnRun = function(self, ply)
        if not ply:Alive() or ply:InVehicle() then
            return
        end

    	local phys = ply:GetPhysicsObject()

        if not ply:IsInWorld() or (IsValid(phys) and phys:IsPenetrating()) or not ply:IsOnGround() then
        	ply:SetPos(ix.FindEmptyPos(ply:GetPos(), {ply}, 800, 30, Vector(16, 16, 64)))
        	ply:Notify("We've attempted to get you un-stuck.")
        else
        	ply:Notify("You don't seem to be stuck. Make a report for assistance.")
        end
    end
}

ix.command.Add("unstuck", unStuckCommand)
