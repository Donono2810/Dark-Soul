-- Script serveur pour gérer les événements multijoueurs et l'équilibrage
local Players = game:GetService("Players")
local MultiplayerModule = require(game.ReplicatedStorage.MultiplayerModule)
local EnemyModule = require(game.ReplicatedStorage.EnemyModule)

Players.PlayerAdded:Connect(function(player)
    if MultiplayerModule.IsCoop() and MultiplayerModule.GetPlayerCount() > 1 then
        local offset = Vector3.new(math.random(-20, 20), 0, math.random(-20, 20))
        EnemyModule.CreateEnemy(Vector3.new(offset.X, 0, offset.Z), "Basic", "KillEnemies")
    end
end)

Players.PlayerRemoving:Connect(function(player)
    -- Rien de spécial pour l'instant; le mode reste disponible
end)

return nil