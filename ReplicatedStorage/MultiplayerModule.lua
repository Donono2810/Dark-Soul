-- ModuleScript pour gérer le mode multijoueur global
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MultiplayerModule = {}

local modeValue = ReplicatedStorage:FindFirstChild("MultiplayerMode")
if not modeValue then
    modeValue = Instance.new("StringValue")
    modeValue.Name = "MultiplayerMode"
    modeValue.Value = "Coop"
    modeValue.Parent = ReplicatedStorage
end

local setModeEvent
local modeChangedEvent

if RunService:IsServer() then
    setModeEvent = ReplicatedStorage:FindFirstChild("SetMultiplayerMode")
    if not setModeEvent then
        setModeEvent = Instance.new("RemoteEvent")
        setModeEvent.Name = "SetMultiplayerMode"
        setModeEvent.Parent = ReplicatedStorage
    end

    modeChangedEvent = ReplicatedStorage:FindFirstChild("MultiplayerModeChanged")
    if not modeChangedEvent then
        modeChangedEvent = Instance.new("RemoteEvent")
        modeChangedEvent.Name = "MultiplayerModeChanged"
        modeChangedEvent.Parent = ReplicatedStorage
    end

    local function broadcastMode(mode)
        modeValue.Value = mode
        modeChangedEvent:FireAllClients(mode)
    end

    local function setMode(player, requestedMode)
        if requestedMode == "Solo" or requestedMode == "Coop" or requestedMode == "PvP" then
            broadcastMode(requestedMode)
            print("[Multiplayer] Mode défini sur : " .. requestedMode .. " par " .. player.Name)
        end
    end

    setModeEvent.OnServerEvent:Connect(setMode)
end

function MultiplayerModule.GetMode()
    return modeValue.Value
end

function MultiplayerModule.SetMode(mode)
    if RunService:IsServer() and (mode == "Solo" or mode == "Coop" or mode == "PvP") then
        modeValue.Value = mode
        if modeChangedEvent then
            modeChangedEvent:FireAllClients(mode)
        end
    end
end

function MultiplayerModule.IsPvP()
    return MultiplayerModule.GetMode() == "PvP"
end

function MultiplayerModule.IsCoop()
    return MultiplayerModule.GetMode() == "Coop"
end

function MultiplayerModule.IsSolo()
    return MultiplayerModule.GetMode() == "Solo"
end

function MultiplayerModule.GetPlayerCount()
    return #Players:GetPlayers()
end

function MultiplayerModule.GetBossHealthScale()
    local playerCount = MultiplayerModule.GetPlayerCount()
    if MultiplayerModule.IsCoop() then
        return 1 + math.max(0, playerCount - 1) * 0.5
    elseif MultiplayerModule.IsPvP() then
        return 1 + math.max(0, playerCount - 1) * 0.2
    end
    return 1
end

function MultiplayerModule.GetEnemyHealthScale()
    local playerCount = MultiplayerModule.GetPlayerCount()
    if MultiplayerModule.IsCoop() then
        return 1 + math.max(0, playerCount - 1) * 0.25
    end
    return 1
end

return MultiplayerModule