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

-- Partie du magasin
local shopPart = Instance.new("Part")
shopPart.Size = Vector3.new(4, 2, 4)
shopPart.Position = Vector3.new(0, 0, -50) -- Près du spawn
shopPart.Anchored = true
shopPart.BrickColor = BrickColor.new("Bright green")
shopPart.Name = "Shop"
shopPart.Parent = workspace

-- Ajouter une étiquette
local shopLabel = Instance.new("SurfaceGui")
shopLabel.Face = Enum.NormalId.Top
shopLabel.Parent = shopPart

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Text = "Magasin\nTouchez pour ouvrir"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.BackgroundTransparency = 1
textLabel.TextScaled = true
textLabel.Parent = shopLabel

shopPart.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        _G.OpenShopForPlayer(player)
    end
end)

-- Partie pour les quêtes dynamiques
local questPart = Instance.new("Part")
questPart.Size = Vector3.new(3, 2, 3)
questPart.Position = Vector3.new(-20, 0, 0) -- Près du spawn
questPart.Anchored = true
questPart.BrickColor = BrickColor.new("Bright blue")
questPart.Name = "QuestBoard"
questPart.Parent = workspace

-- Étiquette
local questLabel = Instance.new("SurfaceGui")
questLabel.Face = Enum.NormalId.Top
questLabel.Parent = questPart

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Text = "Tableau des Quêtes\nTouchez pour une quête dynamique"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.BackgroundTransparency = 1
textLabel.TextScaled = true
textLabel.Parent = questLabel

questPart.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        local QuestModule = require(game.ReplicatedStorage.QuestModule)
        local newQuest = QuestModule.GenerateDynamicQuest(player)
        QuestModule.StartQuest(player, newQuest)

        local notification = Instance.new("Hint")
        notification.Text = "Nouvelle quête : " .. QuestModule.GetQuestDescription(newQuest)
        notification.Parent = player.PlayerGui
        wait(5)
        notification:Destroy()
    end
end)

-- Table de craft
local craftPart = Instance.new("Part")
craftPart.Size = Vector3.new(3, 2, 3)
craftPart.Position = Vector3.new(20, 0, 0) -- Près du spawn
craftPart.Anchored = true
craftPart.BrickColor = BrickColor.new("Bright green")
craftPart.Name = "CraftingTable"
craftPart.Parent = workspace

-- Étiquette
local craftLabel = Instance.new("SurfaceGui")
craftLabel.Face = Enum.NormalId.Top
craftLabel.Parent = craftPart

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Text = "Table de Craft\nTouchez pour ouvrir"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.BackgroundTransparency = 1
textLabel.TextScaled = true
textLabel.Parent = craftLabel

craftPart.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        -- Ouvrir une interface de craft simple (pour l'exemple, craft une potion)
        local CraftModule = require(game.ReplicatedStorage.CraftModule)
        local success, message = CraftModule.CraftItem(player, "Potion")
        if not success then
            local notification = Instance.new("Hint")
            notification.Text = message
            notification.Parent = player.PlayerGui
            wait(3)
            notification:Destroy()
        end
    end
end)

-- Mode Survie
local survivalPart = Instance.new("Part")
survivalPart.Size = Vector3.new(3, 2, 3)
survivalPart.Position = Vector3.new(0, 0, 20) -- Près du spawn
survivalPart.Anchored = true
survivalPart.BrickColor = BrickColor.new("Bright red")
survivalPart.Name = "SurvivalMode"
survivalPart.Parent = workspace

-- Étiquette
local survivalLabel = Instance.new("SurfaceGui")
survivalLabel.Face = Enum.NormalId.Top
survivalLabel.Parent = survivalPart

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Text = "Mode Survie\nTouchez pour commencer"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.BackgroundTransparency = 1
textLabel.TextScaled = true
textLabel.Parent = survivalLabel

survivalPart.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        local SurvivalMode = require(game.ReplicatedStorage.SurvivalMode)
        local success, message = SurvivalMode.StartWave(player, 1)
        local notification = Instance.new("Hint")
        notification.Text = message
        notification.Parent = player.PlayerGui
        wait(3)
        notification:Destroy()
    end
end)

-- Rejoindre une faction
local factionPart = Instance.new("Part")
factionPart.Size = Vector3.new(3, 2, 3)
factionPart.Position = Vector3.new(-40, 0, 0) -- Près du spawn
factionPart.Anchored = true
factionPart.BrickColor = BrickColor.new("Bright yellow")
factionPart.Name = "FactionJoiner"
factionPart.Parent = workspace

-- Étiquette
local factionLabel = Instance.new("SurfaceGui")
factionLabel.Face = Enum.NormalId.Top
factionLabel.Parent = factionPart

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Text = "Rejoindre une Faction\nTouchez pour rejoindre les Chevaliers"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.BackgroundTransparency = 1
textLabel.TextScaled = true
textLabel.Parent = factionLabel

factionPart.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        local FactionModule = require(game.ReplicatedStorage.FactionModule)
        local success, message = FactionModule.JoinFaction(player, "Knights")
        local notification = Instance.new("Hint")
        notification.Text = message
        notification.Parent = player.PlayerGui
        wait(3)
        notification:Destroy()
    end
end)

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

    -- Ajouter de l'or de départ
    local playerData = player:FindFirstChild("PlayerData") or Instance.new("Folder")
    playerData.Name = "PlayerData"
    playerData.Parent = player

    local gold = playerData:FindFirstChild("Gold") or Instance.new("IntValue")
    gold.Name = "Gold"
    gold.Value = 500 -- Or de départ
    gold.Parent = playerData
end)