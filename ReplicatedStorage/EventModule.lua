-- ModuleScript pour gérer les événements temporaires
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local EventModule = {}
local activeEvents = {}
local eventTypes = {
    ["InvasionBoss"] = {duration = 300, reward = "ExpBonus", description = "Boss mondial envahit toutes les zones"},
    ["RaidCoop"] = {duration = 600, reward = "RareItem", description = "Raid coopératif contre vagues d'ennemis"},
    ["NightOfUndead"] = {duration = 1800, reward = "GoldBonus", description = "Ennemis plus forts la nuit"}
}

function EventModule.StartEvent(eventName)
    if not eventTypes[eventName] then return false end
    activeEvents[eventName] = {startTime = tick(), data = eventTypes[eventName]}
    -- Broadcast to all players
    local eventEvent = ReplicatedStorage:FindFirstChild("EventStarted")
    if eventEvent then
        eventEvent:FireAllClients(eventName, eventTypes[eventName])
    end
    return true
end

function EventModule.EndEvent(eventName)
    if activeEvents[eventName] then
        activeEvents[eventName] = nil
        local eventEvent = ReplicatedStorage:FindFirstChild("EventEnded")
        if eventEvent then
            eventEvent:FireAllClients(eventName)
        end
    end
end

function EventModule.GetActiveEvents()
    return activeEvents
end

function EventModule.CheckEventExpiry()
    for name, data in pairs(activeEvents) do
        if tick() - data.startTime > data.data.duration then
            EventModule.EndEvent(name)
        end
    end
end

-- Run expiry check every minute
while true do
    wait(60)
    EventModule.CheckEventExpiry()
end

return EventModule
