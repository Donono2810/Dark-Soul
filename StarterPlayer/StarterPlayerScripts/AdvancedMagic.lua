-- LocalScript pour plus de sorts (bouclier, heal)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)

local SPELL_COOLDOWN = 5

local lastSpellTime = 0

-- Q pour bouclier (réduit dégâts)
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Q then
        if tick() - lastSpellTime > SPELL_COOLDOWN then
            lastSpellTime = tick()
            if InventoryModule.UseItem(player, "ShieldSpell") then
                -- Bouclier temporaire : réduire dégâts pendant 10s
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    local originalHealth = humanoid.Health
                    humanoid.HealthChanged:Connect(function()
                        if humanoid.Health < originalHealth then
                            humanoid.Health = math.max(humanoid.Health + 10, originalHealth) -- Réduire dégâts
                        end
                    end)
                    wait(10)
                    -- Fin du bouclier
                end
            end
        end
    elseif input.KeyCode == Enum.KeyCode.R then
        -- R pour heal (sort de soin)
        if tick() - lastSpellTime > SPELL_COOLDOWN then
            lastSpellTime = tick()
            if InventoryModule.UseItem(player, "HealSpell") then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = math.min(humanoid.Health + 50, humanoid.MaxHealth)
                end
            end
        end
    end
end)