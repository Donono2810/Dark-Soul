-- Script pour le mode Survie (Tower Defense-like)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local SurvivalMode = {}

function SurvivalMode.StartSurvival(player)
    -- Teleport to survival zone
    local survivalZone = workspace:FindFirstChild("SurvivalZone")
    if survivalZone then
        player.Character.HumanoidRootPart.CFrame = survivalZone.Spawn.CFrame
    end
    -- Spawn waves of enemies
    for wave = 1, 10 do
        wait(30) -- Wave interval
        for i = 1, wave * 5 do
            require(game.ReplicatedStorage.EnemyModule).CreateEnemy(Vector3.new(math.random(-50,50), 0, math.random(-50,50)), "Basic", "Survival")
        end
    end
end

function SurvivalMode.EndSurvival(player)
    -- Reward based on survival time
    _G.GainExp(player, 500)
end

return SurvivalMode
