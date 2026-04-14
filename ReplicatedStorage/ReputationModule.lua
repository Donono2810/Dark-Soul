-- ModuleScript pour gérer la réputation et les factions
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local ReputationModule = {}
local playerReputations = {}
local factions = {
    ["Chevaliers"] = {bonus = "defense +10%", quests = {"KillEnemies", "KillBoss"}},
    ["Sorciers"] = {bonus = "mana +20", quests = {"KillEnemies", "CollectCrystals"}},
    ["Mercenaires"] = {bonus = "damage +15%", quests = {"KillEnemies", "PvPKills"}}
}

local reputationStore = DataStoreService:GetDataStore("DarkSoulReputation")

function ReputationModule.GetFactions()
    return factions
end

function ReputationModule.GetPlayerFaction(player)
    return playerReputations[player.UserId] and playerReputations[player.UserId].faction or nil
end

function ReputationModule.GetPlayerReputation(player)
    return playerReputations[player.UserId] and playerReputations[player.UserId].rep or 0
end

function ReputationModule.SetFaction(player, factionName)
    if not factions[factionName] then return false end
    playerReputations[player.UserId] = playerReputations[player.UserId] or {}
    playerReputations[player.UserId].faction = factionName
    playerReputations[player.UserId].rep = playerReputations[player.UserId].rep or 0
    ReputationModule.SavePlayer(player)
    return true
end

function ReputationModule.AddReputation(player, amount)
    local faction = ReputationModule.GetPlayerFaction(player)
    if not faction then return end
    playerReputations[player.UserId].rep = (playerReputations[player.UserId].rep or 0) + amount
    ReputationModule.SavePlayer(player)
end

function ReputationModule.LoadPlayer(player)
    local success, data = pcall(function()
        return reputationStore:GetAsync("REP_" .. player.UserId)
    end)
    if success and type(data) == "table" then
        playerReputations[player.UserId] = data
    else
        playerReputations[player.UserId] = {rep = 0}
    end
end

function ReputationModule.SavePlayer(player)
    local data = playerReputations[player.UserId]
    if data then
        pcall(function()
            reputationStore:SetAsync("REP_" .. player.UserId, data)
        end)
    end
end

return ReputationModule
