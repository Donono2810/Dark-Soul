-- Script serveur pour gérer le classement PvP et les hits PvP
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MultiplayerModule = require(game.ReplicatedStorage.MultiplayerModule)
local LeaderboardModule = require(game.ReplicatedStorage.LeaderboardModule)

local pvpHitEvent = ReplicatedStorage:FindFirstChild("PvpHit")
if not pvpHitEvent then
    pvpHitEvent = Instance.new("RemoteEvent")
    pvpHitEvent.Name = "PvpHit"
    pvpHitEvent.Parent = ReplicatedStorage
end

local recentAttackers = {}

local function getCharacter(player)
    return player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character
end

local function onPvpHit(attacker, targetUserId, damage)
    if not MultiplayerModule.IsPvP() then
        return
    end
    local targetPlayer = Players:GetPlayerByUserId(targetUserId)
    if not targetPlayer or targetPlayer == attacker then
        return
    end
    local targetCharacter = getCharacter(targetPlayer)
    if not targetCharacter then
        return
    end
    local humanoid = targetCharacter:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health > 0 then
        recentAttackers[targetPlayer.UserId] = attacker.UserId
        humanoid:TakeDamage(damage)
    end
end

pvpHitEvent.OnServerEvent:Connect(onPvpHit)

Players.PlayerAdded:Connect(function(player)
    LeaderboardModule.Broadcast()
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            local killerId = recentAttackers[player.UserId]
            if killerId then
                local killer = Players:GetPlayerByUserId(killerId)
                if killer and killer ~= player then
                    LeaderboardModule.AddKill(killer)
                end
                recentAttackers[player.UserId] = nil
            end
        end)
    end)
end)
