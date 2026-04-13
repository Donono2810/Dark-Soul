-- LocalScript pour les contrôles du joueur (combat au corps à corps avec armes)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid")
local mouse = player:GetMouse()
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
local WeaponModule = require(game.ReplicatedStorage.WeaponModule)

local lastAttackTime = 0

mouse.Button1Down:Connect(function()
    local equip = InventoryModule.GetEquipment(player)
    local weapon = equip.weapon or "Sword" -- Arme par défaut
    local stats = WeaponModule.GetWeaponStats(weapon)
    
    if tick() - lastAttackTime > stats.speed then
        lastAttackTime = tick()
        
        -- Animation d'attaque simple
        humanoid:MoveTo(character.HumanoidRootPart.Position + character.HumanoidRootPart.CFrame.LookVector * 2)
        
        -- Détection d'ennemis proches
        local enemies = workspace:GetChildren()
        for _, enemy in pairs(enemies) do
            if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and (enemy.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude < 5 then
                enemy.Humanoid:TakeDamage(stats.damage)
            end
        end
    end
end)