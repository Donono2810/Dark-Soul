-- LocalScript pour les contrôles du joueur (combat avec bonus de classe, stamina et capacités spéciales)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid")
local mouse = player:GetMouse()
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
local WeaponModule = require(game.ReplicatedStorage.WeaponModule)
local ClassModule = require(game.ReplicatedStorage.ClassModule)
local AnimationModule = require(game.ReplicatedStorage.AnimationModule)
local StaminaModule = require(game.ReplicatedStorage.StaminaModule)

StaminaModule.Init(player)

local lastAttackTime = 0

mouse.Button1Down:Connect(function()
    if not StaminaModule.UseStamina(player, 20) then return end -- Coût d'attaque
    
    local equip = InventoryModule.GetEquipment(player)
    local weapon = equip.weapon or "Sword" -- Arme par défaut
    local stats = WeaponModule.GetWeaponStats(weapon)
    
    -- Bonus de classe pour les dégâts
    local className = ClassModule.GetPlayerClass(player)
    local classStats = ClassModule.GetClassStats(className)
    local baseDamage = stats.damage + classStats.damageBonus
    
    if tick() - lastAttackTime > stats.speed then
        lastAttackTime = tick()
        
        -- Jouer l'animation d'attaque
        AnimationModule.PlayAttackAnimation(character, weapon)
        
        -- Détection d'ennemis proches
        local enemies = workspace:GetChildren()
        for _, enemy in pairs(enemies) do
            if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and (enemy.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude < 5 then
                enemy.Humanoid:TakeDamage(baseDamage)
            end
        end
    end
end)

-- Capacité spéciale par classe (touche T)
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.T then
        local className = ClassModule.GetPlayerClass(player)
        if className == "Warrior" and StaminaModule.UseStamina(player, 50) then
            -- Charge brutale : dash en avant avec dégâts
            humanoid:MoveTo(character.HumanoidRootPart.Position + character.HumanoidRootPart.CFrame.LookVector * 20)
            wait(0.5)
            local enemies = workspace:GetChildren()
            for _, enemy in pairs(enemies) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and (enemy.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude < 8 then
                    enemy.Humanoid:TakeDamage(50)
                end
            end
        elseif className == "Mage" and StaminaModule.UseStamina(player, 40) then
            -- Tempête de feu : dégâts AoE
            local pos = character.HumanoidRootPart.Position
            local enemies = workspace:GetChildren()
            for _, enemy in pairs(enemies) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and (enemy.HumanoidRootPart.Position - pos).Magnitude < 15 then
                    enemy.Humanoid:TakeDamage(30)
                end
            end
        elseif className == "Archer" and StaminaModule.UseStamina(player, 30) then
            -- Salve de flèches : tirs multiples
            for i = 1, 5 do
                wait(0.2)
                local enemies = workspace:GetChildren()
                for _, enemy in pairs(enemies) do
                    if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and (enemy.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude < 20 then
                        enemy.Humanoid:TakeDamage(25)
                        break -- Un par tir
                    end
                end
            end
        elseif className == "Rogue" and StaminaModule.UseStamina(player, 60) then
            -- Coup fatal : dégâts élevés sur un ennemi proche
            local enemies = workspace:GetChildren()
            for _, enemy in pairs(enemies) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and (enemy.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude < 5 then
                    enemy.Humanoid:TakeDamage(100)
                    break
                end
            end
        elseif className == "Paladin" and StaminaModule.UseStamina(player, 70) then
            -- Aura protectrice : bouclier temporaire et heal
            humanoid.Health = math.min(humanoid.MaxHealth, humanoid.Health + 50)
            -- Bouclier : réduire dégâts pendant 10s (simplifié ici)
            local shieldEnd = tick() + 10
            local conn
            conn = humanoid.HealthChanged:Connect(function()
                if tick() < shieldEnd then
                    humanoid.Health = humanoid.Health + 5 -- Réduction simple
                else
                    conn:Disconnect()
                end
            end)
        end
    end
end)

-- Régénération de stamina
while true do
    wait(0.1)
    StaminaModule.Update(player)
end