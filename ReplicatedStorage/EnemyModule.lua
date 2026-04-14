-- ModuleScript pour les ennemis (types variés)
local EnemyModule = {}
local QuestModule = require(game.ReplicatedStorage.QuestModule)

local enemyTypes = {
    ["Basic"] = {health = 150, damage = 30, speed = 10, exp = 20, loot = {["Potion"] = 0.3}},
    ["Goblin"] = {health = 100, damage = 20, speed = 15, exp = 15, loot = {["Dagger"] = 0.2}}, -- Rapide
    ["Orc"] = {health = 200, damage = 40, speed = 8, exp = 30, loot = {["Axe"] = 0.3}}, -- Fort
    ["Skeleton"] = {health = 120, damage = 25, speed = 12, exp = 25, loot = {["Bow"] = 0.2}} -- Magique
}

function EnemyModule.CreateEnemy(position, enemyType, questUpdate)
    enemyType = enemyType or "Basic"
    questUpdate = questUpdate or "KillEnemies"
    local stats = enemyTypes[enemyType]
    local enemy = Instance.new("Model")
    enemy.Name = enemyType
    enemy.Parent = workspace
    
    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Size = Vector3.new(2, 2, 1)
    humanoidRootPart.Position = position
    humanoidRootPart.Anchored = false
    humanoidRootPart.BrickColor = enemyType == "Goblin" and BrickColor.new("Bright green") or enemyType == "Orc" and BrickColor.new("Brown") or enemyType == "Skeleton" and BrickColor.new("White") or BrickColor.new("Red")
    humanoidRootPart.Parent = enemy
    
    local humanoid = Instance.new("Humanoid")
    humanoid.Health = stats.health
    humanoid.MaxHealth = stats.health
    humanoid.WalkSpeed = stats.speed
    humanoid.Parent = enemy
    
-- ModuleScript pour les ennemis (types variés)
local EnemyModule = {}
local QuestModule = require(game.ReplicatedStorage.QuestModule)
local SideQuestModule = require(game.ReplicatedStorage.SideQuestModule)

local enemyTypes = {
    ["Basic"] = {health = 150, damage = 30, speed = 10, exp = 20, loot = {["Potion"] = 0.3}},
    ["Goblin"] = {health = 100, damage = 20, speed = 15, exp = 15, loot = {["Dagger"] = 0.2}}, -- Rapide
    ["Orc"] = {health = 200, damage = 40, speed = 8, exp = 30, loot = {["Axe"] = 0.3}}, -- Fort
    ["Skeleton"] = {health = 120, damage = 25, speed = 12, exp = 25, loot = {["Bow"] = 0.2}} -- Magique
}

function EnemyModule.CreateEnemy(position, enemyType, questUpdate)
    enemyType = enemyType or "Basic"
    questUpdate = questUpdate or "KillEnemies"
    local stats = enemyTypes[enemyType]
    local enemy = Instance.new("Model")
    enemy.Name = enemyType
    enemy.Parent = workspace
    
    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Size = Vector3.new(2, 2, 1)
    humanoidRootPart.Position = position
    humanoidRootPart.Anchored = false
    humanoidRootPart.BrickColor = enemyType == "Goblin" and BrickColor.new("Bright green") or enemyType == "Orc" and BrickColor.new("Brown") or enemyType == "Skeleton" and BrickColor.new("White") or BrickColor.new("Red")
    humanoidRootPart.Parent = enemy
    
    local humanoid = Instance.new("Humanoid")
    humanoid.Health = stats.health
    humanoid.MaxHealth = stats.health
    humanoid.WalkSpeed = stats.speed
    humanoid.Parent = enemy
    
    humanoid.Died:Connect(function()
        -- Donner exp au joueur proche
        local players = game.Players:GetPlayers()
        for _, player in pairs(players) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and (char.HumanoidRootPart.Position - position).Magnitude < 20 then
                _G.GainExp(player, stats.exp)
                QuestModule.UpdateQuest(player, questUpdate, 1)
                -- Side quests
                if enemyType == "Goblin" then
                    SideQuestModule.UpdateProgress("KillGoblins", 1)
                end
                -- Loot drop
                for item, prob in pairs(stats.loot) do
                    if math.random() < prob then
                        require(game.ReplicatedStorage.InventoryModule).AddItem(player, item, 1)
                    end
                end
            end
        end
        enemy:Destroy()
    end)
    
    -- Comportement
    local function AttackPlayer()
        local players = game.Players:GetPlayers()
        for _, player in pairs(players) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local distance = (char.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                if distance < 10 then
                    humanoid:MoveTo(char.HumanoidRootPart.Position)
                    wait(2)
                    if distance < 3 then
                        char.Humanoid:TakeDamage(stats.damage)
                    end
                end
            end
        end
    end
    
    while humanoid.Health > 0 do
        AttackPlayer()
        wait(3)
    end
end

return EnemyModule