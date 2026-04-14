-- Script client pour gérer l'interface utilisateur (UI pour mode photo, contrôles, etc.)
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local PhotoModeModule = require(game.ReplicatedStorage.PhotoModeModule)
local CustomControlsModule = require(game.ReplicatedStorage.CustomControlsModule)
local ImprovedUIModule = require(game.ReplicatedStorage.ImprovedUIModule)

-- Créer une GUI simple pour le mode photo
local photoGui = Instance.new("ScreenGui")
photoGui.Name = "PhotoModeGui"
photoGui.Parent = playerGui

local photoButton = Instance.new("TextButton")
photoButton.Size = UDim2.new(0, 100, 0, 50)
photoButton.Position = UDim2.new(0.8, 0, 0.1, 0)
photoButton.Text = "Mode Photo"
photoButton.Parent = photoGui

photoButton.MouseButton1Click:Connect(function()
    PhotoModeModule.EnterPhotoMode(player)
end)

-- GUI pour contrôles personnalisables
local controlsGui = Instance.new("Frame")
controlsGui.Size = UDim2.new(0.3, 0, 0.5, 0)
controlsGui.Position = UDim2.new(0.7, 0, 0.25, 0)
controlsGui.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
controlsGui.Visible = false -- Montrer sur demande
controlsGui.Parent = playerGui

local dodgeLabel = Instance.new("TextLabel")
dodgeLabel.Text = "Touche Dodge: " .. CustomControlsModule.DefaultControls.Dodge
dodgeLabel.Size = UDim2.new(1, 0, 0.2, 0)
dodgeLabel.Parent = controlsGui

-- Améliorer l'UI générale
ImprovedUIModule.EnhanceUI(player)

-- Fonction pour afficher/masquer la GUI des contrôles
function ToggleControlsGui()
    controlsGui.Visible = not controlsGui.Visible
end

-- Exemple : lier à une touche
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.C then -- Exemple touche C pour contrôles
        ToggleControlsGui()
    end
end)