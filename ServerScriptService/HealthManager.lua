-- Script serveur pour gérer la santé et les niveaux du joueur
local Players = game:GetService("Players")

local HEALTH_MAX_BASE = 100
local HEALTH_REGEN_RATE = 1
local HEALTH_REGEN_DELAY = 5

local playerLevels = {} -- Niveaux des joueurs
local playerExp = {} -- Expérience

local EXP_TO_LEVEL = 100 -- Exp par niveau

Players.PlayerAdded:Connect(function(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")
    
    if humanoid then
        playerLevels[player.UserId] = playerLevels[player.UserId] or 1
        playerExp[player.UserId] = playerExp[player.UserId] or 0
        
        local level = playerLevels[player.UserId]
        humanoid.Health = HEALTH_MAX_BASE + (level - 1) * 20 -- Santé augmente avec le niveau
        humanoid.MaxHealth = humanoid.Health
        
        -- Régénération lente
        local lastDamageTime = 0
        humanoid.HealthChanged:Connect(function()
            lastDamageTime = tick()
        end)
        
        humanoid.Died:Connect(function()
            -- Perte d'exp au décès (comme Dark Souls)
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
            char.Humanoid.MaxHealth = HEALTH_MAX_BASE + (playerLevels[player.UserId] - 1) * 20
            char.Humanoid.Health = char.Humanoid.MaxHealth
        end
    end
end

-- Exposer la fonction
_G.GainExp = GainExp