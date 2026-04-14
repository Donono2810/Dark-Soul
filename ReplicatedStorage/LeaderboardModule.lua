-- ModuleScript pour le classement PvP
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LeaderboardModule = {}
local pvpKills = {}

local leaderboardEvent = ReplicatedStorage:FindFirstChild("LeaderboardUpdated")
if not leaderboardEvent then
    leaderboardEvent = Instance.new("RemoteEvent")
    leaderboardEvent.Name = "LeaderboardUpdated"
    leaderboardEvent.Parent = ReplicatedStorage
end

function LeaderboardModule.GetKills(userId)
    return pvpKills[userId] or 0
end

function LeaderboardModule.AddKill(player)
    if not player or not player.UserId then
        return
    end
    pvpKills[player.UserId] = (pvpKills[player.UserId] or 0) + 1
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

return LeaderboardModule