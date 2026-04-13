-- LocalScript pour l'UI simple (santé, niveau, inventaire)
local player = game.Players.LocalPlayer
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)

-- Créer une GUI simple
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

-- Mettre à jour l'UI
player.CharacterAdded:Connect(function(char)
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.HealthChanged:Connect(function()
            healthLabel.Text = "Santé: " .. math.floor(humanoid.Health) .. "/" .. humanoid.MaxHealth
        end)
    end
end)

-- Mettre à jour inventaire (simple)
while true do
    wait(5)
    local inv = InventoryModule.GetInventory(player)
    local text = "Inventaire: "
    for item, qty in pairs(inv) do
        text = text .. item .. ": " .. qty .. " "
    end
    inventoryLabel.Text = text
    -- Niveau (simulé, pas stocké côté client)
    levelLabel.Text = "Niveau: ? (Vérifiez serveur)"
end