-- Script pour gérer un boss (avec exp et compétences)
local BossModule = {}
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BuffModule = require(game.ReplicatedStorage.BuffModule)
local MultiplayerModule = require(game.ReplicatedStorage.MultiplayerModule)

function BossModule.CreateBoss(position, expReward)
    expReward = expReward or 200
    local boss = Instance.new("Model")
    boss.Name = "Boss"
    boss.Parent = workspace
    
    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Size = Vector3.new(4, 4, 2)
    humanoidRootPart.Position = position
    humanoidRootPart.Anchored = false
    humanoidRootPart.Parent = boss
    
    local humanoid = Instance.new("Humanoid")
    local healthScale = MultiplayerModule.GetBossHealthScale()
    humanoid.Health = math.floor(500 * healthScale)
    humanoid.MaxHealth = math.floor(500 * healthScale)
    humanoid.WalkSpeed = 15
    humanoid.Parent = boss
    
    humanoid.Died:Connect(function()
        -- Donner exp
        local players = game.Players:GetPlayers()
        for _, player in pairs(players) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and (char.HumanoidRootPart.Position - position).Magnitude < 50 then
                _G.GainExp(player, expReward)
            end
        end
        boss:Destroy()
    end)
    
    -- Phases avec compétences
    local function AttackPlayer()
        local players = game.Players:GetPlayers()
        for _, player in pairs(players) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local distance = (char.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                if distance < 20 then
                    humanoid:MoveTo(char.HumanoidRootPart.Position)
                    wait(1.5)
                    if distance < 5 then
                        local bossScale = MultiplayerModule.GetBossHealthScale()
                        if humanoid.Health > 350 then
                            -- Phase 1: Attaque basique + poison
                            char.Humanoid:TakeDamage(math.floor(50 * bossScale))
                            BuffModule.ApplyPoison(player, char)
                        elseif humanoid.Health > 150 then
                            -- Phase 2: Attaque AoE + stun
                            local pos = char.HumanoidRootPart.Position
                            local allPlayers = game.Players:GetPlayers()
                            for _, p in pairs(allPlayers) do
                                local c = p.Character
                                if c and c:FindFirstChild("HumanoidRootPart") and (c.HumanoidRootPart.Position - pos).Magnitude < 10 then
                                    c.Humanoid:TakeDamage(math.floor(40 * bossScale))
                                    c.Humanoid.WalkSpeed = 0
                                    wait(2)
                                    c.Humanoid.WalkSpeed = 16 -- Reset
                                end
                            end
                        else
                            -- Phase 3: Summon minions + attaque puissante
                            EnemyModule.CreateEnemy(position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)), "Basic")
                            char.Humanoid:TakeDamage(math.floor(80 * bossScale))
                        end
                        wait(2)
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

local secretBosses = {
    ["AncientGuardian"] = {
        health = 1000,
        damage = 50,
        expReward = 1000,
        ability = "SummonMinions",
        description = "Gardien ancien des profondeurs, invoque des minions pour aider au combat."
    },
    ["ShadowDragon"] = {
        health = 1500,
        damage = 80,
        expReward = 1500,
        ability = "FireBreath",
        description = "Dragon des ombres, crache du feu et se téléporte."
    },
    ["NecromancerKing"] = {
        health = 1200,
        damage = 60,
        expReward = 1200,
        ability = "RaiseDead",
        description = "Roi nécromancien, ressuscite les ennemis morts."
    },
    ["CrystalBehemoth"] = {
        health = 2000,
        damage = 100,
        expReward = 2000,
        ability = "CrystalShards",
        description = "Béhémoth de cristal, lance des éclats et se régénère."
    },
    ["VoidSerpent"] = {
        health = 800,
        damage = 40,
        expReward = 800,
        ability = "VoidPull",
        description = "Serpent du vide, attire les joueurs et inflige des dégâts de zone."
    }
}

function BossModule.CreateSecretBoss(bossName, position)
    local bossData = secretBosses[bossName]
    if not bossData then return end
    
    local boss = Instance.new("Model")
    boss.Name = bossName
    boss.Parent = workspace
    
    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Size = Vector3.new(6, 6, 3)
    humanoidRootPart.Position = position
    humanoidRootPart.Anchored = false
    humanoidRootPart.BrickColor = BrickColor.new("Really black")
    humanoidRootPart.Parent = boss
    
    local humanoid = Instance.new("Humanoid")
    local healthScale = MultiplayerModule.GetBossHealthScale()
    humanoid.Health = math.floor(bossData.health * healthScale)
    humanoid.MaxHealth = math.floor(bossData.health * healthScale)
    humanoid.WalkSpeed = 20
    humanoid.Parent = boss
    
    humanoid.Died:Connect(function()
        -- Donner exp et récompenses spéciales
        local players = game.Players:GetPlayers()
        for _, player in pairs(players) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and (char.HumanoidRootPart.Position - position).Magnitude < 50 then
                _G.GainExp(player, bossData.expReward)
                -- Récompense légendaire
                require(game.ReplicatedStorage.InventoryModule).AddItem(player, "PhoenixPotion", 1)
            end
        end
        boss:Destroy()
    end)
    
    -- Compétence spéciale
    local function SpecialAbility()
        if bossData.ability == "SummonMinions" then
            for i = 1, 3 do
                EnemyModule.CreateEnemy(position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)), "Basic", "BossMinion")
            end
        elseif bossData.ability == "FireBreath" then
            -- Zone de feu
            local firePart = Instance.new("Part")
            firePart.Size = Vector3.new(20, 1, 20)
            firePart.Position = position + Vector3.new(0, -2, 0)
            firePart.Anchored = true
            firePart.BrickColor = BrickColor.new("Bright red")
            firePart.Parent = workspace
            wait(3)
            firePart:Destroy()
        elseif bossData.ability == "RaiseDead" then
            -- Ressusciter ennemis proches
            local enemies = workspace:GetChildren()
            for _, enemy in pairs(enemies) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health <= 0 then
                    enemy.Humanoid.Health = enemy.Humanoid.MaxHealth
                end
            end
        elseif bossData.ability == "CrystalShards" then
            -- Lancer des éclats
            for i = 1, 5 do
                local shard = Instance.new("Part")
                shard.Size = Vector3.new(1, 1, 1)
                shard.Position = position
                shard.Anchored = false
                shard.BrickColor = BrickColor.new("Institutional white")
                shard.Parent = workspace
                shard:ApplyAngularImpulse(Vector3.new(math.random(-100,100), math.random(-100,100), math.random(-100,100)))
                wait(0.5)
            end
        elseif bossData.ability == "VoidPull" then
            -- Attirer joueurs
            local players = game.Players:GetPlayers()
            for _, player in pairs(players) do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local direction = (position - char.HumanoidRootPart.Position).Unit
                    char.HumanoidRootPart:ApplyImpulse(direction * 500)
                end
            end
        end
    end
    
    -- Boucle d'attaque avec compétence spéciale
    while humanoid.Health > 0 do
        wait(5)
        SpecialAbility()
        wait(5)
    end
end

function BossModule.GetSecretBosses()
    return secretBosses
end