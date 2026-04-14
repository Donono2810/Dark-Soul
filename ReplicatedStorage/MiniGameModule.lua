-- ModuleScript pour les mini-jeux et défis quotidiens
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local MiniGameModule = {}
local dailyChallenges = {
    {name = "Kill10Enemies", description = "Tuer 10 ennemis", reward = {exp = 100, item = "Potion"}},
    {name = "Collect5Crystals", description = "Collecter 5 Crystal Shards", reward = {exp = 50, item = "EtherPotion"}},
    {name = "Survive5Minutes", description = "Survivre 5 minutes sans mourir", reward = {exp = 200, item = "GreatPotion"}}
}

local playerProgress = {}

function MiniGameModule.GetDailyChallenges()
    return dailyChallenges
end

function MiniGameModule.UpdateProgress(player, challengeName, progress)
    playerProgress[player.UserId] = playerProgress[player.UserId] or {}
    playerProgress[player.UserId][challengeName] = (playerProgress[player.UserId][challengeName] or 0) + progress
    for _, challenge in ipairs(dailyChallenges) do
        if challenge.name == challengeName and playerProgress[player.UserId][challengeName] >= 1 then
            MiniGameModule.CompleteChallenge(player, challenge)
            break
        end
    end
end

function MiniGameModule.CompleteChallenge(player, challenge)
    -- Reward player
    _G.GainExp(player, challenge.reward.exp)
    require(game.ReplicatedStorage.InventoryModule).AddItem(player, challenge.reward.item, 1)
    playerProgress[player.UserId][challenge.name] = nil -- Reset for next day
end

function MiniGameModule.StartMiniGame(gameType)
    if gameType == "ArenaDuel" then
        -- Simple duel arena
        -- Teleport players, start timer, etc.
    elseif gameType == "TreasureHunt" then
        -- Hide treasures in zones
    end
end

return MiniGameModule
