local PLUGIN = PLUGIN

ix.command.Add('Apply', {
    description = 'Says your name and CID to a CP.',
    OnRun = function(self, client)
        local character = client:GetCharacter()

        if character then
            local cid = character:GetData'cid'
            
            if cid then
                ix.chat.Send(client, 'me', "Shows ID: " .. client:Name()..' # '..cid)
            else
                return 'You don´t own a CID!'
            end
        end
    end
})
