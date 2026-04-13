-- Script pour initialiser le jeu (ennemis, boss, items)
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)

-- Placer ennemis
EnemyModule.CreateEnemy(Vector3.new(10, 0, 10), 20)
EnemyModule.CreateEnemy(Vector3.new(-10, 0, -10), 20)
EnemyModule.CreateEnemy(Vector3.new(0, 0, 20), 20)

-- Boss
BossModule.CreateBoss(Vector3.new(0, 0, 30), 200)

-- Donner items de départ aux joueurs
game.Players.PlayerAdded:Connect(function(player)
    InventoryModule.AddItem(player, "Potion", 3)
    InventoryModule.AddItem(player, "Sword", 1)
    InventoryModule.AddItem(player, "Fireball", 5)
    InventoryModule.EquipItem(player, "Sword")
end)