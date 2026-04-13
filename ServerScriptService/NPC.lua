-- Script pour un PNJ qui donne des quêtes
local QuestModule = require(game.ReplicatedStorage.QuestModule)

local npc = Instance.new("Model")
npc.Name = "NPC"
npc.Parent = workspace

local humanoidRootPart = Instance.new("Part")
humanoidRootPart.Name = "HumanoidRootPart"
humanoidRootPart.Size = Vector3.new(2, 2, 1)
humanoidRootPart.Position = Vector3.new(5, 0, 0)
humanoidRootPart.Anchored = true
humanoidRootPart.BrickColor = BrickColor.new("Bright blue")
humanoidRootPart.Parent = npc

local humanoid = Instance.new("Humanoid")
humanoid.Health = 100
humanoid.MaxHealth = 100
humanoid.Parent = npc

-- Interaction : toucher le PNJ pour commencer quête
humanoidRootPart.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        QuestModule.StartQuest(player, "KillEnemies")
        print("Quête commencée : Tuez 5 ennemis !")
    end
end)