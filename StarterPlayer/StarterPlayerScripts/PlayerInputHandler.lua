-- Script client pour gérer les entrées joueur (dodge, magie, etc.)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid")

local DodgeModule = require(game.ReplicatedStorage.DodgeModule)
local MagicModule = require(game.ReplicatedStorage.MagicModule)
local SpectatorModule = require(game.ReplicatedStorage.SpectatorModule)
local PhotoModeModule = require(game.ReplicatedStorage.PhotoModeModule)
local CustomControlsModule = require(game.ReplicatedStorage.CustomControlsModule)

local UserInputService = game:GetService("UserInputService")

-- Gestion des contrôles personnalisables
local controls = CustomControlsModule.DefaultControls

-- Fonction pour gérer les entrées
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode[controls.Dodge] then
        DodgeModule.Dodge(player)
    elseif input.KeyCode == Enum.KeyCode[controls.CastSpell] then
        -- Exemple : lancer un sort de feu
        MagicModule.CastSpell(player, "Fire", nil) -- target à déterminer
    elseif input.KeyCode == Enum.KeyCode.P then -- Mode photo
        PhotoModeModule.EnterPhotoMode(player)
    elseif input.KeyCode == Enum.KeyCode.S then -- Mode spectateur (exemple)
        SpectatorModule.EnterSpectator(player, nil) -- target à sélectionner
    end
end)

-- Autres gestionnaires pour souris, etc.
-- Par exemple, pour magie avec clic droit
local mouse = player:GetMouse()
mouse.Button2Down:Connect(function()
    local target = mouse.Target
    if target and target.Parent:FindFirstChild("Humanoid") then
        MagicModule.CastSpell(player, "Ice", target.Parent)
    end
end)