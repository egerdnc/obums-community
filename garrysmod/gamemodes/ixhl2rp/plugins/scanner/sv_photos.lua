util.AddNetworkString("ixScannerData")
util.AddNetworkString("ixScannerPicture")
util.AddNetworkString("ixScannerClearPicture")

net.Receive("ixScannerData", function(length, client)
    if (IsValid(client.ixScn) and client:GetViewEntity() == client.ixScn and (client.ixNextPic or 0) < CurTime()) then
        local delay = ix.config.Get("pictureDelay", 15)
        client.ixNextPic = CurTime() + delay - 1

        local length = net.ReadUInt(16)
        local data = net.ReadData(length)

        if (length != #data) then
            return
        end

        local receivers = {}

        for k, v in ipairs(player.GetAll()) do
            if (hook.Run("CanPlayerReceiveScan", v, client)) then
                receivers[#receivers + 1] = v
                v:EmitSound("npc/overwatch/radiovoice/preparevisualdownload.wav")
            end
        end

        if (#receivers > 0) then
            net.Start("ixScannerData")
                net.WriteUInt(#data, 16)
                net.WriteData(data, #data)
            net.Send(receivers)

            if (Schema.AddCombineDisplayMessage) then
                Schema:AddCombineDisplayMessage("Prepare to receive visual download...")
            end
        end
    end
end)

net.Receive("ixScannerPicture", function(length, client)
    if (not IsValid(client.ixScn)) then return end
    if (client:GetViewEntity() ~= client.ixScn) then return end
    if ((client.ixNextFlash or 0) >= CurTime()) then return end

    client.ixNextFlash = CurTime() + 1
    client.ixScn:Flash()
end)