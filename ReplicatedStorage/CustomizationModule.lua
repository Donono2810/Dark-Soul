-- ModuleScript pour la personnalisation visuelle (skins, couleurs)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local CustomizationModule = {}
local playerCustomizations = {}
local availableSkins = {
    ["Warrior"] = {color = Color3.fromRGB(139, 69, 19), unlocked = true},
    ["Mage"] = {color = Color3.fromRGB(0, 0, 255), unlocked = true},
    ["Archer"] = {color = Color3.fromRGB(0, 128, 0), unlocked = true},
    ["Rogue"] = {color = Color3.fromRGB(128, 128, 128), unlocked = true},
    ["Paladin"] = {color = Color3.fromRGB(255, 215, 0), unlocked = true},
    ["GoldenKnight"] = {color = Color3.fromRGB(255, 215, 0), unlocked = false}, -- VIP only
    ["ShadowAssassin"] = {color = Color3.fromRGB(0, 0, 0), unlocked = false} -- Rare reward
}

local customizationStore = DataStoreService:GetDataStore("DarkSoulCustomization")

function CustomizationModule.GetAvailableSkins()
    return availableSkins
end

function CustomizationModule.GetPlayerSkin(player)
    return playerCustomizations[player.UserId] and playerCustomizations[player.UserId].skin or "Warrior"
end

function CustomizationModule.SetPlayerSkin(player, skinName)
    if not availableSkins[skinName] then return false end
    if not availableSkins[skinName].unlocked and not require(game.ReplicatedStorage.VipModule).IsVip(player) then return false end
    playerCustomizations[player.UserId] = playerCustomizations[player.UserId] or {}
    playerCustomizations[player.UserId].skin = skinName
    CustomizationModule.SavePlayer(player)
    CustomizationModule.ApplySkin(player)
    return true
end

function CustomizationModule.ApplySkin(player)
    local character = player.Character
    if not character then return end
    local skinName = CustomizationModule.GetPlayerSkin(player)
    local skinData = availableSkins[skinName]
    if skinData then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Color = skinData.color
            end
        end
    end
end

function CustomizationModule.LoadPlayer(player)
    local success, data = pcall(function()
        return customizationStore:GetAsync("CUST_" .. player.UserId)
    end)
    if success and type(data) == "table" then
        playerCustomizations[player.UserId] = data
    else
        playerCustomizations[player.UserId] = {skin = "Warrior"}
    end
    CustomizationModule.ApplySkin(player)
end

function CustomizationModule.SavePlayer(player)
    local data = playerCustomizations[player.UserId]
    if data then
        pcall(function()
            customizationStore:SetAsync("CUST_" .. player.UserId, data)
        end)
    end
end

return CustomizationModule
