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
local ItemModule = require(game.ReplicatedStorage.ItemModule)
local MultiplayerModule = require(game.ReplicatedStorage.MultiplayerModule)
local uis = game:GetService("UserInputService")

StaminaModule.Init(player)

local lastAttackTime = 0
local parryActive = false
local parryEndTime = 0

-- Parry (touche U)
uis.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.U then
        parryActive = true
        parryEndTime = tick() + 1 -- Parry pendant 1s
        wait(1)
        parryActive = false
    end
end)

-- Appliquer parry dans HealthChanged
character.Humanoid.HealthChanged:Connect(function(oldHealth, newHealth)
    if newHealth < oldHealth and parryActive then
        local damage = oldHealth - newHealth
        local reducedDamage = damage * 0.5 -- 50% réduction
        character.Humanoid.Health = character.Humanoid.Health + (damage - reducedDamage)
        parryActive = false -- Parry consommé
    end
end)

mouse.Button1Down:Connect(function()
    if not StaminaModule.UseStamina(player, 20) then return end -- Coût d'attaque
    
    local equip = InventoryModule.GetEquipment(player)
    local weapon = equip.weapon or "Sword" -- Arme par défaut
    local stats = WeaponModule.GetWeaponStats(weapon)
    
    -- Stats avancées des items
    local itemStats = ItemModule.GetItemStats(weapon)
    local baseDamage = stats.damage + (itemStats.damage or 0)
    local critChance = itemStats.crit or 0
    local lifesteal = itemStats.lifesteal or 0
    
    -- Bonus de classe pour les dégâts
    local className = ClassModule.GetPlayerClass(player)
    local classStats = ClassModule.GetClassStats(className)
    local multiplier = _G.nextAttackMultiplier or 1
    _G.nextAttackMultiplier = 1 -- Reset
    local finalDamage = (baseDamage + classStats.damageBonus) * multiplier
    
    -- Coup critique
    if math.random(1, 100) <= critChance then
        finalDamage = finalDamage * 1.5 -- 50% bonus crit
        -- Afficher "CRIT!" (optionnel)
    end
    
    if tick() - lastAttackTime > stats.speed then
        lastAttackTime = tick()
        
        -- Jouer l'animation d'attaque
        AnimationModule.PlayAttackAnimation(character, weapon)
        
        -- Détection d'ennemis proches
        local targets = workspace:GetChildren()
        for _, target in pairs(targets) do
            if target:IsA("Model") and target:FindFirstChild("Humanoid") and target:FindFirstChild("HumanoidRootPart") then
                local distance = (target.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                if distance < 5 then
                    local playerTarget = game.Players:GetPlayerFromCharacter(target)
                    if playerTarget then
                        if MultiplayerModule.IsPvP() and target ~= character then
                            target.Humanoid:TakeDamage(finalDamage)
                        end
                    else
                        target.Humanoid:TakeDamage(finalDamage)
                    end
                    
                    -- Lifesteal
                    if lifesteal > 0 then
                        humanoid.Health = math.min(humanoid.Health + (finalDamage * lifesteal / 100), humanoid.MaxHealth)
                    end
                end
            end
        end
    end
end)

-- Capacité spéciale par classe (touche T)
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
    elseif input.KeyCode == Enum.KeyCode.Y then
        -- Compétence active par classe
        local className = ClassModule.GetPlayerClass(player)
        if className == "Warrior" and StaminaModule.UseStamina(player, 40) then
            -- Cri de guerre : boost dmg 20s
            -- Simulé avec un buff temporaire
            local buffEnd = tick() + 20
            local originalDamage = ClassModule.GetClassStats(className).damageBonus
            ClassModule.GetClassStats(className).damageBonus = originalDamage + 10
            wait(20)
            ClassModule.GetClassStats(className).damageBonus = originalDamage
        elseif className == "Mage" and StaminaModule.UseStamina(player, 30) then
            -- Bouclier magique : absorbe 50 dmg
            local shieldHealth = 50
            local conn
            conn = humanoid.HealthChanged:Connect(function(oldHealth, newHealth)
                if newHealth < oldHealth then
                    local damage = oldHealth - newHealth
                    if shieldHealth > 0 then
                        local absorbed = math.min(damage, shieldHealth)
                        shieldHealth = shieldHealth - absorbed
                        humanoid.Health = humanoid.Health + absorbed
                        if shieldHealth <= 0 then
                            conn:Disconnect()
                        end
                    end
                end
            end)
            wait(30) -- Durée du bouclier
            if conn then conn:Disconnect() end
        elseif className == "Archer" and StaminaModule.UseStamina(player, 25) then
            -- Tir précis : dmg x2 sur prochain tir
            -- Simulé en doublant le dmg de la prochaine attaque
            local nextAttackDoubled = true
            local conn
            conn = humanoid:GetPropertyChangedSignal("Health"):Connect(function() -- Placeholder, besoin d'un signal d'attaque
                -- Pour simplifier, on double le dmg de la prochaine attaque manuellement
            end)
            -- Idée : utiliser une variable globale pour multiplier le dmg
            _G.nextAttackMultiplier = 2
            wait(10) -- Durée
            _G.nextAttackMultiplier = 1
        elseif className == "Rogue" and StaminaModule.UseStamina(player, 50) then
            -- Invisibilité : 5s
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0.5
                end
            end
            wait(5)
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                end
            end
        elseif className == "Paladin" and StaminaModule.UseStamina(player, 60) then
            -- Jugement : dégâts sacrés AoE
            local pos = character.HumanoidRootPart.Position
            local enemies = workspace:GetChildren()
            for _, enemy in pairs(enemies) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and (enemy.HumanoidRootPart.Position - pos).Magnitude < 12 then
                    enemy.Humanoid:TakeDamage(40)
                end
            end
        end
    end
end)

-- Régénération de stamina
while true do
    wait(0.1)
    StaminaModule.Update(player)
end