local PLUGIN = PLUGIN
PLUGIN.name = "XP System"
PLUGIN.author = "Sydres#9887"
PLUGIN.description = "XP System for Obums Community made by Sydres#9887"

DONATOR_XP = 10
REGULAR_XP = 5

    function PLUGIN:PlayerLoadedCharacter(client)
        local character = client:GetCharacter()
        local isDonator = client:GetData("donator", false)
        local xp = character:GetData("xp", 0)

        timer.Simple(600, function()
            if isDonator == true then
                character:SetData("xp", xp + DONATOR_XP)
            else
                character:SetData("xp", xp + REGULAR_XP)
            end
        end)

        timer.Simple(10, function()
            print("CHAR XP: ", xp)
        end)
    end
