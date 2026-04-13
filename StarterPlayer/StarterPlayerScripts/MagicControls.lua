-- LocalScript pour la magie (sorts)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local mouse = player:GetMouse()
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)

local SPELL_COOLDOWN = 3

local lastSpellTime = 0

mouse.Button2Down:Connect(function() -- Clic droit pour sort
    if tick() - lastSpellTime > SPELL_COOLDOWN then
        lastSpellTime = tick()
        
        if InventoryModule.UseItem(player, "Fireball") then
            -- Lancer une boule de feu (effet simple : dégâts à distance)
            local fireball = Instance.new("Part")
            fireball.Size = Vector3.new(1, 1, 1)
            fireball.Position = character.HumanoidRootPart.Position + character.HumanoidRootPart.CFrame.LookVector * 5
            fireball.Anchored = true
            fireball.BrickColor = BrickColor.new("Bright red")
            fireball.Parent = workspace
            
            -- Détection d'ennemis
            local enemies = workspace:GetChildren()
            for _, enemy in pairs(enemies) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and (enemy.HumanoidRootPart.Position - fireball.Position).Magnitude < 10 then
                    enemy.Humanoid:TakeDamage(40)
                end
            end
            
            wait(1)
            fireball:Destroy()
        end
    end
end)