-- ModuleScript pour le classement PvP
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local LeaderboardModule = {}
local pvpKills = {}
local leaderboardEvent = ReplicatedStorage:FindFirstChild("LeaderboardUpdated")
local leaderboardStore = DataStoreService:GetDataStore("DarkSoulPvPLeaderboard")
local DATASTORE_KEY = "GlobalPvPLeaderboard"

if not leaderboardEvent then
    leaderboardEvent = Instance.new("RemoteEvent")
    leaderboardEvent.Name = "LeaderboardUpdated"
    leaderboardEvent.Parent = ReplicatedStorage
end

local function serializeKills(kills)
    local result = {}
    for userId, value in pairs(kills) do
        result[tostring(userId)] = value
    end
    return result
end

local function deserializeKills(data)
    local result = {}
    if type(data) ~= "table" then
        return result
    end
    for key, value in pairs(data) do
        local userId = tonumber(key)
        if userId and type(value) == "number" then
            result[userId] = value
        end
    end
    return result
end

local function loadLeaderboard()
    local success, data = pcall(function()
        return leaderboardStore:GetAsync(DATASTORE_KEY)
    end)
    if success and type(data) == "table" then
        pvpKills = deserializeKills(data)
    else
        pvpKills = {}
    end
end

local function saveLeaderboard()
    pcall(function()
        leaderboardStore:UpdateAsync(DATASTORE_KEY, function(oldData)
            local saved = deserializeKills(oldData)
            for userId, kills in pairs(pvpKills) do
                saved[userId] = math.max(saved[userId] or 0, kills)
            end
            return serializeKills(saved)
        end)
    end)
end

function LeaderboardModule.GetKills(userId)
    return pvpKills[userId] or 0
end

function LeaderboardModule.AddKill(player)
    if not player or not player.UserId then
        return
    end
    pvpKills[player.UserId] = (pvpKills[player.UserId] or 0) + 1
    saveLeaderboard()
    LeaderboardModule.Broadcast()
end

function LeaderboardModule.GetLeaderboard(limit)
    local sorted = {}
    for userId, kills in pairs(pvpKills) do
        local player = Players:GetPlayerByUserId(userId)
        table.insert(sorted, {
            name = player and player.Name or tostring(userId),
            kills = kills
        })
    end
    table.sort(sorted, function(a, b)
        return a.kills > b.kills
    end)
    local result = {}
    limit = limit or 10
    for i = 1, math.min(limit, #sorted) do
        table.insert(result, sorted[i])
    end
    return result
end

function LeaderboardModule.Broadcast()
    local top = LeaderboardModule.GetLeaderboard(10)
    leaderboardEvent:FireAllClients(top)
end

function LeaderboardModule.GetLeaderboardEvent()
    return leaderboardEvent
end

loadLeaderboard()

return LeaderboardModule