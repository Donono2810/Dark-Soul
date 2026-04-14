-- ModuleScript pour gérer le statut VIP des joueurs et le stocker en DataStore
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local VipModule = {}
local vipCache = {}
local vipStore = DataStoreService:GetDataStore("DarkSoulVipData")

local vipStatusEvent = ReplicatedStorage:FindFirstChild("VipStatusUpdated")
if not vipStatusEvent then
    vipStatusEvent = Instance.new("RemoteEvent")
    vipStatusEvent.Name = "VipStatusUpdated"
    vipStatusEvent.Parent = ReplicatedStorage
end

local function getDataKey(userId)
    return "VIP_" .. tostring(userId)
end

local function fireVipStatus(player)
    if player and player.Parent then
        vipStatusEvent:FireClient(player, vipCache[player.UserId] == true)
    end
end

function VipModule.IsVip(player)
    if not player then
        return false
    end
    return vipCache[player.UserId] == true
end

function VipModule.SetVip(player, isVip)
    if not player then
        return
    end
    vipCache[player.UserId] = isVip == true
    fireVipStatus(player)
end

function VipModule.LoadPlayer(player)
    if not player then
        return
    end
    local success, result = pcall(function()
        return vipStore:GetAsync(getDataKey(player.UserId))
    end)
    vipCache[player.UserId] = success and result == true
    fireVipStatus(player)
end

function VipModule.SavePlayer(player)
    if not player then
        return
    end
    local isVip = vipCache[player.UserId] == true
    pcall(function()
        vipStore:SetAsync(getDataKey(player.UserId), isVip)
    end)
end

function VipModule.GetStatusEvent()
    return vipStatusEvent
end

return VipModule
