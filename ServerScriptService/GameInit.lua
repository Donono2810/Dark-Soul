-- Script pour initialiser le jeu (ennemis, boss, items, sauvegarde)
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)
local BossModule = require(game.ReplicatedStorage.BossModule)
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
local SaveModule = require(game.ReplicatedStorage.SaveModule)

-- Placer ennemis Zone 1
EnemyModule.CreateEnemy(Vector3.new(10, 0, 10), "Basic", "KillEnemies")
EnemyModule.CreateEnemy(Vector3.new(-10, 0, -10), "Basic", "KillEnemies")
EnemyModule.CreateEnemy(Vector3.new(0, 0, 20), "Basic", "KillEnemies")

-- Boss Zone 1
BossModule.CreateBoss(Vector3.new(0, 0, 30), 200)

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