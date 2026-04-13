-- LocalScript pour l'UI améliorée (santé, niveau, inventaire, quêtes)
local player = game.Players.LocalPlayer
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
local QuestModule = require(game.ReplicatedStorage.QuestModule)

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

local inventoryLabel = Instance.new("TextLabel")
inventoryLabel.Size = UDim2.new(0, 300, 0, 100)
inventoryLabel.Position = UDim2.new(0, 10, 0, 130)
inventoryLabel.Text = "Inventaire: Vide"
inventoryLabel.Parent = screenGui

local questLabel = Instance.new("TextLabel")
questLabel.Size = UDim2.new(0, 300, 0, 50)
questLabel.Position = UDim2.new(0, 10, 0, 240)
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

invButton.MouseButton1Click:Connect(function()
    invFrame.Visible = not invFrame.Visible
    if invFrame.Visible then
        -- Remplir avec items
        for _, child in pairs(invFrame:GetChildren()) do child:Destroy() end
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