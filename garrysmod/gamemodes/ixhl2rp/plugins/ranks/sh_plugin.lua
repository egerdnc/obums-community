PLUGIN.name = "Ranks"
PLUGIN.author = "GeFake"
PLUGIN.description = "The ranks for factions"

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_plugin.lua")

--[[---------------------------------------------------------

-------------------------------
------------ USAGE ------------
-------------------------------

Add Ranks table into faction you need

FACTION.Ranks = {
    [1] = {"Private", "icon16/medal_bronze_1.png", CLASS_RECRUIT, true}
}

Let's look at the table in more detail:

"Recruit" ---> name of the rank
------------------------------------
"icon16/medal_bronze_1.png" ---> icon, used in PopulateCharacterInfo (tooltip). If you don't need this, just set nil
------------------------------------
CLASS_ELITE ---> class (you need put class index), sets when rank changed. If you don't need this, just set nil
------------------------------------
true ---> Boolean for high ranks. "true" means that a player can assign ranks to other players. If you don't need this, just don't set anything

The finished table looks like this:

FACTION.Ranks = {
    [1] = {"Private", nil, CLASS_RECRUIT},
    [2] = {"Corporal", nil, CLASS_RECRUIT},
    [3] = {"Specialist", nil, nil},
    [4] = {"Sergeant", "icon16/medal_bronze_1.png", CLASS_OFFICER},
    [5] = {"Master Sergeant", "icon16/medal_silver_1.png", CLASS_SENIOR, true},
    [6] = {"Sergeant Major", "icon16/medal_gold_1.png", CLASS_SENIOR, true}
}

----------------------------------
------------ COMMANDS ------------
----------------------------------

CharSetRank /// Chat command ONLY for admins. If you need set rank for any character, use this.

----------------------------------

CharRaise /// Chat command for everyone. Player may raise a character if:

    1. The client rank is lower than the target rank
    2. Client character rank has the fourth true expression in the rank table ( [6] = {"Sergeant Major", nil, nil, true} )
    3. Client faction == Target faction
    4. If client != target

-----------------------------------
------------ FUNCTIONS ------------
-----------------------------------

Plugin has function called when character rank changed

You need add this into your faction:

function FACTION:OnRankChanged(client, oldValue, value)
    --- Do something ---
end

-----------------------------------------------------------]]

ix.char.RegisterVar("rank", { 
    field = "rank",
    fieldType = ix.type.number,
    default = 1
})

ix.command.Add("CharSetRank", {
    arguments = {
        ix.type.player,
        ix.type.number
    },
    description = "@cmdCharSetRank",
    adminOnly = true,
    OnRun = function(self, client, target, rank)
        local factionTable = ix.faction.Get(target:Team())
        local rankTable = factionTable.Ranks
        local character = target:GetCharacter()

        if not rankTable or not rankTable[rank] or not isnumber(rank) or (rank > #rankTable) then return client:NotifyLocalized("undefinedRank") end

        if rankTable[rank][3] then
            local class = ix.class.list[rankTable[rank][3]]
            character:SetClass(class.index)
        end

        character:SetRank(rank)
        client:NotifyLocalized("characterRaiseAdmin", target:Name(), rankTable[rank][1])
        target:NotifyLocalized("characterRaiseNotify", rankTable[rank][1])
    end
})

ix.command.Add("CharRaise", {
    arguments = {
        ix.type.player,
        ix.type.number
    },
    description = "@cmdCharRaise",
    OnRun = function(self, client, target, rank)
        local factionTable = ix.faction.Get(target:Team())
        local rankTable = factionTable.Ranks
        local character = target:GetCharacter()

        if (client:SteamID() == target:SteamID()) then return client:NotifyLocalized("cannotAllowRaiseYourself") end
        if not rankTable or not rankTable[rank] or not isnumber(rank) or (rank > #rankTable) then return client:NotifyLocalized("undefinedRank") end
        if (client:Team() ~= target:Team()) or !rankTable[client:GetCharacter():GetRank()][4] or (rank >= client:GetCharacter():GetRank()) then return client:NotifyLocalized("cannotAllowRaise") end

        if rankTable[rank][3] then
            local class = ix.class.list[rankTable[rank][3]]
            character:SetClass(class.index)
        end

        character:SetRank(rank)
        client:NotifyLocalized("characterRaisePlayer", target:Name(), rankTable[rank][1])
        target:NotifyLocalized("characterRaiseNotify", rankTable[rank][1])
    end
})