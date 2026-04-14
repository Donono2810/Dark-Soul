-- Script pour initialiser le jeu (ennemis, boss, items, sauvegarde)
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
local SaveModule = require(game.ReplicatedStorage.SaveModule)
local HiddenItemsModule = require(game.ReplicatedStorage.HiddenItemsModule)

-- Placer ennemis Zone 1
EnemyModule.CreateEnemy(Vector3.new(10, 0, 10), "Basic", "KillEnemies")
EnemyModule.CreateEnemy(Vector3.new(-10, 0, -10), "Basic", "KillEnemies")
EnemyModule.CreateEnemy(Vector3.new(0, 0, 20), "Basic", "KillEnemies")

-- Boss Zone 1
BossModule.CreateBoss(Vector3.new(0, 0, 30), 200)

-- Items cachés Zone 1
local zone1Items = HiddenItemsModule.GetItemsForZone(1)
for _, itemInfo in ipairs(zone1Items) do
    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)
    part.Position = itemInfo.data.position
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 0.5
    part.BrickColor = BrickColor.new("Bright yellow")
    part.Name = itemInfo.name
    part.Parent = workspace

    part.Touched:Connect(function(hit)
        local player = game.Players:GetPlayerFromCharacter(hit.Parent)
        if player then
            HiddenItemsModule.GiveReward(player, itemInfo.name)
            part:Destroy()
        end
    end)
end

-- Items cachés pour toutes les zones
for zone = 2, 8 do
    local items = HiddenItemsModule.GetItemsForZone(zone)
    for _, itemInfo in ipairs(items) do
        local part = Instance.new("Part")
        part.Size = Vector3.new(2, 2, 2)
        part.Position = itemInfo.data.position
        part.Anchored = true
        part.CanCollide = false
        part.Transparency = 0.5
        part.BrickColor = BrickColor.new("Bright yellow")
        part.Name = itemInfo.name
        part.Parent = workspace

        part.Touched:Connect(function(hit)
            local player = game.Players:GetPlayerFromCharacter(hit.Parent)
            if player then
                HiddenItemsModule.GiveReward(player, itemInfo.name)
                part:Destroy()
            end
        end)
    end
end

-- Item caché Donjon Secret
local secretItems = HiddenItemsModule.GetItemsForZone("SecretDungeon")
for _, itemInfo in ipairs(secretItems) do
    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)
    part.Position = itemInfo.data.position
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 0.5
    part.BrickColor = BrickColor.new("Bright yellow")
    part.Name = itemInfo.name
    part.Parent = workspace

    part.Touched:Connect(function(hit)
        local player = game.Players:GetPlayerFromCharacter(hit.Parent)
        if player then
            HiddenItemsModule.GiveReward(player, itemInfo.name)
            part:Destroy()
        end
    end)
end

-- Donner items de départ aux joueurs
game.Players.PlayerAdded:Connect(function(player)
    SaveModule.LoadData(player) -- Charger sauvegarde
    InventoryModule.AddItem(player, "Potion", 5)
    InventoryModule.AddItem(player, "Sword", 1)
    InventoryModule.AddItem(player, "Dagger", 1)
    InventoryModule.AddItem(player, "Fireball", 5)
    InventoryModule.AddItem(player, "ShieldSpell", 3)
    InventoryModule.AddItem(player, "HealSpell", 3)
    InventoryModule.EquipItem(player, "Sword")
end)