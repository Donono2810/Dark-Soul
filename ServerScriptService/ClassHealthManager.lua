-- Script serveur pour appliquer les bonus de classe
local Players = game:GetService("Players")
local ClassModule = require(game.ReplicatedStorage.ClassModule)

local HEALTH_MAX_BASE = 100
local HEALTH_REGEN_RATE = 1
local HEALTH_REGEN_DELAY = 5

local playerLevels = {}
local playerExp = {}
local EXP_TO_LEVEL = 100

Players.PlayerAdded:Connect(function(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")
    
    if humanoid then
        playerLevels[player.UserId] = playerLevels[player.UserId] or 1
        playerExp[player.UserId] = playerExp[player.UserId] or 0
        
        -- Appliquer les stats de la classe
        local className = ClassModule.GetPlayerClass(player)
        local classStats = ClassModule.GetClassStats(className)
        local healthWithClass = classStats.health + (playerLevels[player.UserId] - 1) * 20
        
        humanoid.Health = healthWithClass
        humanoid.MaxHealth = healthWithClass
        
        -- Bonus de vitesse selon la classe
        local baseSpeed = classStats.speed
        if className == "Archer" then
            baseSpeed = baseSpeed + 2 -- Passive: Vitesse +2
        end
        humanoid.WalkSpeed = baseSpeed
        
        -- Régénération lente avec bonus passif
        local regenRate = HEALTH_REGEN_RATE
        if className == "Warrior" then
            regenRate = regenRate + 5 -- Passive: Régénération accrue
        end
        
        local lastDamageTime = 0
        humanoid.HealthChanged:Connect(function(oldHealth, newHealth)
            lastDamageTime = tick()
            -- Passive Rogue: Esquive +10% (réduit dmg reçu)
            if className == "Rogue" and newHealth < oldHealth then
                local damage = oldHealth - newHealth
                local reducedDamage = damage * 0.9
                humanoid.Health = humanoid.Health + (damage - reducedDamage)
            end
            -- Passive Paladin: Résistance +10%
            if className == "Paladin" and newHealth < oldHealth then
                local damage = oldHealth - newHealth
                local reducedDamage = damage * 0.9
                humanoid.Health = humanoid.Health + (damage - reducedDamage)
            end
            -- Défense d'armure
            if newHealth < oldHealth then
                local damage = oldHealth - newHealth
                local defense = require(game.ReplicatedStorage.InventoryModule).GetTotalDefense(player)
                local reducedDamage = damage * (1 - defense / 100) -- Réduction en %
                humanoid.Health = humanoid.Health + (damage - reducedDamage)
            end
        end)
        
        humanoid.Died:Connect(function()
            playerExp[player.UserId] = math.max(0, playerExp[player.UserId] - 50)
        end)
        
        while true do
            wait(1)
            if tick() - lastDamageTime > HEALTH_REGEN_DELAY and humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = math.min(humanoid.Health + regenRate, humanoid.MaxHealth)
            end
        end
    end
end)

-- Fonction pour gagner de l'exp
function GainExp(player, amount)
    playerExp[player.UserId] = (playerExp[player.UserId] or 0) + amount
    if playerExp[player.UserId] >= EXP_TO_LEVEL * playerLevels[player.UserId] then
        playerLevels[player.UserId] = playerLevels[player.UserId] + 1
        playerExp[player.UserId] = 0
        -- Level up : augmenter santé
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            local className = ClassModule.GetPlayerClass(player)
            local classStats = ClassModule.GetClassStats(className)
            char.Humanoid.MaxHealth = classStats.health + (playerLevels[player.UserId] - 1) * 20
            char.Humanoid.Health = char.Humanoid.MaxHealth
        end
    end
end

_G.GainExp = GainExp