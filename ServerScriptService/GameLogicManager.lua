-- Script serveur pour gérer la logique serveur (sauvegarde, fatigue, récompenses, etc.)
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local FatigueModule = require(game.ReplicatedStorage.FatigueModule)
local DailyRewardsModule = require(game.ReplicatedStorage.DailyRewardsModule)
local AdvancedLevelsModule = require(game.ReplicatedStorage.AdvancedLevelsModule)
local AutoSaveModule = require(game.ReplicatedStorage.AutoSaveModule)

-- DataStore pour sauvegarde
local playerDataStore = DataStoreService:GetDataStore("PlayerData")

-- Fonction de sauvegarde
local function SavePlayerData(player)
    local data = {
        Fatigue = player:GetAttribute("Fatigue") or 0,
        SoulLevel = player:GetAttribute("SoulLevel") or 100,
        -- Ajouter d'autres données
    }
    local success, err = pcall(function()
        playerDataStore:SetAsync(player.UserId, data)
    end)
    if not success then
        warn("Erreur sauvegarde pour " .. player.Name .. ": " .. err)
    end
end

-- Fonction de chargement
local function LoadPlayerData(player)
    local data = playerDataStore:GetAsync(player.UserId)
    if data then
        player:SetAttribute("Fatigue", data.Fatigue or 0)
        player:SetAttribute("SoulLevel", data.SoulLevel or 100)
        -- Charger autres
    end
end

-- Gestion des joueurs
Players.PlayerAdded:Connect(function(player)
    LoadPlayerData(player)
    -- Démarrer sauvegarde auto
    coroutine.wrap(function()
        AutoSaveModule.AutoSave(player)
    end)()
end)

Players.PlayerRemoving:Connect(function(player)
    SavePlayerData(player)
end)

-- Gestion de la fatigue (exemple : appliquer après combat)
-- Cela pourrait être appelé depuis d'autres scripts
function ApplyFatigueToPlayer(player, amount)
    FatigueModule.ApplyFatigue(player, amount)
end

-- Récompenses quotidiennes
Players.PlayerAdded:Connect(function(player)
    DailyRewardsModule.ClaimDaily(player)
end)

-- Niveaux avancés
-- Fonction pour monter de niveau
function LevelUpSoul(player)
    AdvancedLevelsModule.LevelUpSoul(player)
    SavePlayerData(player)
end

-- Exposer les fonctions si besoin
_G.ApplyFatigue = ApplyFatigueToPlayer
_G.LevelUpSoul = LevelUpSoul