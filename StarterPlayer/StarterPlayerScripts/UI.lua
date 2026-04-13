-- LocalScript pour l'UI avec classe affichée
local player = game.Players.LocalPlayer
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
local QuestModule = require(game.ReplicatedStorage.QuestModule)
local CraftModule = require(game.ReplicatedStorage.CraftModule)
local ClassModule = require(game.ReplicatedStorage.ClassModule)

-- Créer une GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local healthLabel = Instance.new("TextLabel")
healthLabel.Size = UDim2.new(0, 200, 0, 50)
healthLabel.Position = UDim2.new(0, 10, 0, 10)
healthLabel.Text = "Santé: 100/100"
healthLabel.Parent = screenGui

local levelLabel = Instance.new("TextLabel")
levelLabel.Size = UDim2.new(0, 200, 0, 50)
levelLabel.Position = UDim2.new(0, 10, 0, 70)
levelLabel.Text = "Niveau: 1"
levelLabel.Parent = screenGui

-- Afficher la classe
local classLabel = Instance.new("TextLabel")
classLabel.Size = UDim2.new(0, 200, 0, 50)
classLabel.Position = UDim2.new(0, 10, 0, 130)
classLabel.Text = "Classe: " .. ClassModule.GetPlayerClass(player)
classLabel.Parent = screenGui

local inventoryLabel = Instance.new("TextLabel")
inventoryLabel.Size = UDim2.new(0, 300, 0, 100)
inventoryLabel.Position = UDim2.new(0, 10, 0, 190)
inventoryLabel.Text = "Inventaire: Vide"
inventoryLabel.Parent = screenGui

local questLabel = Instance.new("TextLabel")
questLabel.Size = UDim2.new(0, 300, 0, 50)
questLabel.Position = UDim2.new(0, 10, 0, 300)
questLabel.Text = "Quêtes: Aucune"
questLabel.Parent = screenGui

-- Bouton pour ouvrir inventaire détaillé
local invButton = Instance.new("TextButton")
invButton.Size = UDim2.new(0, 100, 0, 50)
invButton.Position = UDim2.new(0, 320, 0, 10)
invButton.Text = "Inventaire"
invButton.Parent = screenGui

local invFrame = Instance.new("Frame")
invFrame.Size = UDim2.new(0, 400, 0, 300)
invFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
invFrame.Visible = false
invFrame.Parent = screenGui

-- Bouton craft dans l'inventaire
local craftButton = Instance.new("TextButton")
craftButton.Size = UDim2.new(0, 100, 0, 50)
craftButton.Position = UDim2.new(0, 10, 0, 250)
craftButton.Text = "Craft Greatsword"
craftButton.Parent = invFrame

craftButton.MouseButton1Click:Connect(function()
    if CraftModule.CraftItem(player, "Greatsword") then
        print("Greatsword craftée !")
        invFrame.Visible = false
        invFrame.Visible = true
    else
        print("Ingrédients insuffisants.")
    end
end)

invButton.MouseButton1Click:Connect(function()
    invFrame.Visible = not invFrame.Visible
    if invFrame.Visible then
        -- Remplir avec items
        for _, child in pairs(invFrame:GetChildren()) do if child ~= craftButton then child:Destroy() end end
        local inv = InventoryModule.GetInventory(player)
        local y = 10
        for item, qty in pairs(inv) do
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 200, 0, 30)
            label.Position = UDim2.new(0, 10, 0, y)
            label.Text = item .. ": " .. qty
            label.Parent = invFrame
            y = y + 35
        end
    end
end)

-- Mettre à jour
player.CharacterAdded:Connect(function(char)
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.HealthChanged:Connect(function()
            healthLabel.Text = "Santé: " .. math.floor(humanoid.Health) .. "/" .. humanoid.MaxHealth
        end)
    end
end)

while true do
    wait(5)
    local inv = InventoryModule.GetInventory(player)
    local text = "Inventaire: "
    for item, qty in pairs(inv) do
        text = text .. item .. ": " .. qty .. " "
    end
    inventoryLabel.Text = text
    
    local quests = QuestModule.GetQuests(player)
    local qtext = "Quêtes: "
    for quest, data in pairs(quests) do
        qtext = qtext .. quest .. " (" .. data.progress .. "/" .. data.required .. ") "
    end
    questLabel.Text = qtext
end