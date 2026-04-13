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
        humanoid.WalkSpeed = classStats.speed
        
        -- Régénération lente
        local lastDamageTime = 0
        humanoid.HealthChanged:Connect(function()
            lastDamageTime = tick()
        end)
        
        humanoid.Died:Connect(function()
            playerExp[player.UserId] = math.max(0, playerExp[player.UserId] - 50)
        end)
        
        while true do
            wait(1)
            if tick() - lastDamageTime > HEALTH_REGEN_DELAY and humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = math.min(humanoid.Health + HEALTH_REGEN_RATE, humanoid.MaxHealth)
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