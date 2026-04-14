-- Script pour gérer un boss (avec exp et compétences)
local BossModule = {}
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BuffModule = require(game.ReplicatedStorage.BuffModule)
local MultiplayerModule = require(game.ReplicatedStorage.MultiplayerModule)

local bossDrops = {
    ["Boss"] = {
        items = {"Greatsword", "PhoenixPotion", "CrystalShard"},
        chances = {0.3, 0.2, 0.5}
    },
    ["CrystalColossus"] = {
        items = {"FrostHammer", "CrystalShard", "DragonScale"},
        chances = {0.25, 0.6, 0.3}
    },
    ["MagmaTitan"] = {
        items = {"PhoenixPotion", "MagmaCore", "GoldOre"},
        chances = {0.3, 0.4, 0.5}
    },
    ["AncientGuardian"] = {
        items = {"DivineShield", "CrystalShard", "DragonScale"},
        chances = {0.2, 0.8, 0.4}
    },
    ["ShadowDragon"] = {
        items = {"EnchantedSword", "Fireball", "DragonScale"},
        chances = {0.15, 0.5, 0.7}
    },
    ["NecromancerKing"] = {
        items = {"Scythe", "EtherPotion", "GoldOre"},
        chances = {0.25, 0.6, 0.6}
    },
    ["CrystalBehemoth"] = {
        items = {"FrostHammer", "CrystalShard", "ManaCrystal"},
        chances = {0.12, 0.95, 0.5}
    },
    ["VoidSerpent"] = {
        items = {"LightningRapier", "VoidEssence", "EtherPotion"},
        chances = {0.1, 0.85, 0.6}
    }
}

local bossTypes = {
    ["Boss"] = {baseHealth = 500, baseDamage = 50, walkSpeed = 15, expReward = 200, ability = "Default"},
    ["CrystalColossus"] = {baseHealth = 900, baseDamage = 70, walkSpeed = 12, expReward = 800, ability = "CrystalShards"},
    ["MagmaTitan"] = {baseHealth = 1200, baseDamage = 90, walkSpeed = 16, expReward = 1000, ability = "FireBreath"}
}

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

local function giveLoot(player, bossName)
    local drops = bossDrops[bossName]
    if not drops then
        return
    end
    for i, item in ipairs(drops.items) do
        if math.random() < drops.chances[i] then
            require(game.ReplicatedStorage.InventoryModule).AddItem(player, item, 1)
        end
    end
end

local function getNearbyPlayers(position, range)
    local result = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            if (char.HumanoidRootPart.Position - position).Magnitude < range then
                table.insert(result, player)
            end
        end
    end
    return result
end

local function distributeLoot(position, bossName)
    local nearbyPlayers = getNearbyPlayers(position, 50)
    if #nearbyPlayers == 0 then
        return
    end
    for _, player in ipairs(nearbyPlayers) do
        giveLoot(player, bossName)
    end
end

function BossModule.CreateBoss(position, expReward, bossType)
    bossType = bossType or "Boss"
    local typeData = bossTypes[bossType] or bossTypes["Boss"]
    expReward = expReward or typeData.expReward
    local boss = Instance.new("Model")
    boss.Name = bossType
    boss.Parent = workspace

    local humanoidRootPart = Instance.new("Part")
    humanoidRootPart.Name = "HumanoidRootPart"
    humanoidRootPart.Size = Vector3.new(4, 4, 2)
    humanoidRootPart.Position = position
    humanoidRootPart.Anchored = false
    humanoidRootPart.Parent = boss

    local humanoid = Instance.new("Humanoid")
    local healthScale = MultiplayerModule.GetBossHealthScale()
    humanoid.Health = math.floor(typeData.baseHealth * healthScale)
    humanoid.MaxHealth = humanoid.Health
    humanoid.WalkSpeed = typeData.walkSpeed
    humanoid.Parent = boss

    humanoid.Died:Connect(function()
        local nearbyPlayers = getNearbyPlayers(position, 50)
        for _, player in ipairs(nearbyPlayers) do
            _G.GainExp(player, expReward)
        end
        distributeLoot(position, bossType)
        boss:Destroy()
    end)

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
                        if typeData.ability == "CrystalShards" then
                            for i = 1, 4 do
                                local shard = Instance.new("Part")
                                shard.Size = Vector3.new(1, 1, 1)
                                shard.Position = position + Vector3.new(math.random(-10,10), 0, math.random(-10,10))
                                shard.Anchored = false
                                shard.BrickColor = BrickColor.new("Institutional white")
                                shard.Parent = workspace
                                shard:ApplyAngularImpulse(Vector3.new(math.random(-100,100), math.random(-100,100), math.random(-100,100)))
                            end
                            char.Humanoid:TakeDamage(math.floor(typeData.baseDamage * bossScale))
                        elseif typeData.ability == "FireBreath" then
                            local firePart = Instance.new("Part")
                            firePart.Size = Vector3.new(20, 1, 20)
                            firePart.Position = position + Vector3.new(0, -2, 0)
                            firePart.Anchored = true
                            firePart.BrickColor = BrickColor.new("Bright red")
                            firePart.Parent = workspace
                            wait(3)
                            firePart:Destroy()
                            char.Humanoid:TakeDamage(math.floor(typeData.baseDamage * bossScale))
                        elseif humanoid.Health > 350 then
                            char.Humanoid:TakeDamage(math.floor(typeData.baseDamage * bossScale))
                            BuffModule.ApplyPoison(player, char)
                        elseif humanoid.Health > 150 then
                            local pos = char.HumanoidRootPart.Position
                            for _, p in pairs(game.Players:GetPlayers()) do
                                local c = p.Character
                                if c and c:FindFirstChild("HumanoidRootPart") and (c.HumanoidRootPart.Position - pos).Magnitude < 10 then
                                    c.Humanoid:TakeDamage(math.floor((typeData.baseDamage - 10) * bossScale))
                                    c.Humanoid.WalkSpeed = 0
                                    wait(2)
                                    c.Humanoid.WalkSpeed = 16
                                end
                            end
                        else
                            EnemyModule.CreateEnemy(position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)), "Basic")
                            char.Humanoid:TakeDamage(math.floor((typeData.baseDamage + 20) * bossScale))
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

function BossModule.CreateSecretBoss(bossName, position)
    local bossData = secretBosses[bossName]
    if not bossData then
        return
    end

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
        local nearbyPlayers = getNearbyPlayers(position, 50)
        for _, player in ipairs(nearbyPlayers) do
            _G.GainExp(player, bossData.expReward)
            require(game.ReplicatedStorage.InventoryModule).AddItem(player, "PhoenixPotion", 1)
        end
        distributeLoot(position, bossName)
        boss:Destroy()
    end)

    local function SpecialAbility()
        if bossData.ability == "SummonMinions" then
            for i = 1, 3 do
                EnemyModule.CreateEnemy(position + Vector3.new(math.random(-10,10), 0, math.random(-10,10)), "Basic", "BossMinion")
            end
        elseif bossData.ability == "FireBreath" then
            local firePart = Instance.new("Part")
            firePart.Size = Vector3.new(20, 1, 20)
            firePart.Position = position + Vector3.new(0, -2, 0)
            firePart.Anchored = true
            firePart.BrickColor = BrickColor.new("Bright red")
            firePart.Parent = workspace
            wait(3)
            firePart:Destroy()
        elseif bossData.ability == "RaiseDead" then
            local enemies = workspace:GetChildren()
            for _, enemy in pairs(enemies) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health <= 0 then
                    enemy.Humanoid.Health = enemy.Humanoid.MaxHealth
                end
            end
        elseif bossData.ability == "CrystalShards" then
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

    while humanoid.Health > 0 do
        wait(5)
        SpecialAbility()
        wait(5)
    end
end

function BossModule.GetSecretBosses()
    return secretBosses
end

return BossModule