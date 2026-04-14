-- LocalScript pour le HUD (barres de santé et stamina)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid")
local StaminaModule = require(game.ReplicatedStorage.StaminaModule)

StaminaModule.Init(player)

-- Créer la GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HUD"
screenGui.Parent = player.PlayerGui

-- Barre de santé
local healthFrame = Instance.new("Frame")
healthFrame.Size = UDim2.new(0, 200, 0, 20)
healthFrame.Position = UDim2.new(0, 10, 1, -50)
healthFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
healthFrame.Parent = screenGui

local healthBar = Instance.new("Frame")
healthBar.Size = UDim2.new(1, 0, 1, 0)
healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
healthBar.Parent = healthFrame

local healthLabel = Instance.new("TextLabel")
healthLabel.Size = UDim2.new(1, 0, 1, 0)
healthLabel.BackgroundTransparency = 1
healthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
healthLabel.Text = "HP: " .. humanoid.Health .. "/" .. humanoid.MaxHealth
healthLabel.Parent = healthFrame

-- Barre de stamina
local staminaFrame = Instance.new("Frame")
staminaFrame.Size = UDim2.new(0, 200, 0, 20)
staminaFrame.Position = UDim2.new(0, 10, 1, -25)
staminaFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
staminaFrame.Parent = screenGui

local staminaBar = Instance.new("Frame")
staminaBar.Size = UDim2.new(1, 0, 1, 0)
staminaBar.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
staminaBar.Parent = staminaFrame

local staminaLabel = Instance.new("TextLabel")
staminaLabel.Size = UDim2.new(1, 0, 1, 0)
staminaLabel.BackgroundTransparency = 1
staminaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
staminaLabel.Text = "Stamina: 100/100"
staminaLabel.Parent = staminaFrame

-- Mettre à jour les barres
humanoid.HealthChanged:Connect(function()
    local healthPercent = humanoid.Health / humanoid.MaxHealth
    healthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
    healthLabel.Text = "HP: " .. humanoid.Health .. "/" .. humanoid.MaxHealth
end)

-- Mettre à jour la stamina
while true do
    wait(0.1)
    StaminaModule.Update(player)
    local stamina = StaminaModule.GetStamina(player)
    local staminaPercent = stamina / 100
    staminaBar.Size = UDim2.new(staminaPercent, 0, 1, 0)
    staminaLabel.Text = "Stamina: " .. math.floor(stamina) .. "/100"
end