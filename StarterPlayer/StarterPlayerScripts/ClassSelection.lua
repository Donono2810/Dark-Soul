-- LocalScript pour choisir sa classe au démarrage
local player = game.Players.LocalPlayer
local ClassModule = require(game.ReplicatedStorage.ClassModule)
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)

-- Créer une GUI pour choisir la classe
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ClassSelectionGui"
screenGui.Parent = player.PlayerGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 400, 0, 50)
titleLabel.Position = UDim2.new(0.5, -200, 0, 50)
titleLabel.Text = "Choisir votre classe"
titleLabel.TextSize = 24
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Parent = screenGui

local classes = ClassModule.GetClasses()
local yPos = 120
local selectedClass = "Warrior"

-- Créer des boutons pour chaque classe
for className, stats in pairs(classes) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 300, 0, 60)
    button.Position = UDim2.new(0.5, -150, 0, yPos)
    button.Text = className .. " - " .. stats.description
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = screenGui
    
    button.MouseButton1Click:Connect(function()
        selectedClass = className
        -- Changer couleur du bouton sélectionné
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end)
    
    yPos = yPos + 70
end

-- Bouton de confirmation
local confirmButton = Instance.new("TextButton")
confirmButton.Size = UDim2.new(0, 150, 0, 50)
confirmButton.Position = UDim2.new(0.5, -75, 0, yPos + 20)
confirmButton.Text = "Confirmer"
confirmButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmButton.Parent = screenGui

confirmButton.MouseButton1Click:Connect(function()
    -- Envoyer au serveur pour confirmer la classe
    ClassModule.SetPlayerClass(player, selectedClass)
    
    -- Donner les items de départ de la classe
    local stats = classes[selectedClass]
    for item, qty in pairs(stats.startItems) do
        InventoryModule.AddItem(player, item, qty)
    end
    
    -- Changer l'apparence selon la classe
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            local bodyColors = character:FindFirstChild("Body Colors")
            if not bodyColors then
                bodyColors = Instance.new("BodyColors")
                bodyColors.Parent = character
            end
            
            if selectedClass == "Warrior" then
                bodyColors.HeadColor3 = Color3.fromRGB(139, 69, 19) -- Marron
                bodyColors.TorsoColor3 = Color3.fromRGB(139, 69, 19)
                bodyColors.LeftArmColor3 = Color3.fromRGB(139, 69, 19)
                bodyColors.RightArmColor3 = Color3.fromRGB(139, 69, 19)
                bodyColors.LeftLegColor3 = Color3.fromRGB(139, 69, 19)
                bodyColors.RightLegColor3 = Color3.fromRGB(139, 69, 19)
            elseif selectedClass == "Mage" then
                bodyColors.HeadColor3 = Color3.fromRGB(0, 0, 255) -- Bleu
                bodyColors.TorsoColor3 = Color3.fromRGB(0, 0, 255)
                bodyColors.LeftArmColor3 = Color3.fromRGB(0, 0, 255)
                bodyColors.RightArmColor3 = Color3.fromRGB(0, 0, 255)
                bodyColors.LeftLegColor3 = Color3.fromRGB(0, 0, 255)
                bodyColors.RightLegColor3 = Color3.fromRGB(0, 0, 255)
            elseif selectedClass == "Archer" then
                bodyColors.HeadColor3 = Color3.fromRGB(0, 128, 0) -- Vert
                bodyColors.TorsoColor3 = Color3.fromRGB(0, 128, 0)
                bodyColors.LeftArmColor3 = Color3.fromRGB(0, 128, 0)
                bodyColors.RightArmColor3 = Color3.fromRGB(0, 128, 0)
                bodyColors.LeftLegColor3 = Color3.fromRGB(0, 128, 0)
                bodyColors.RightLegColor3 = Color3.fromRGB(0, 128, 0)
            elseif selectedClass == "Rogue" then
                bodyColors.HeadColor3 = Color3.fromRGB(128, 128, 128) -- Gris
                bodyColors.TorsoColor3 = Color3.fromRGB(128, 128, 128)
                bodyColors.LeftArmColor3 = Color3.fromRGB(128, 128, 128)
                bodyColors.RightArmColor3 = Color3.fromRGB(128, 128, 128)
                bodyColors.LeftLegColor3 = Color3.fromRGB(128, 128, 128)
                bodyColors.RightLegColor3 = Color3.fromRGB(128, 128, 128)
            elseif selectedClass == "Paladin" then
                bodyColors.HeadColor3 = Color3.fromRGB(255, 215, 0) -- Or
                bodyColors.TorsoColor3 = Color3.fromRGB(255, 215, 0)
                bodyColors.LeftArmColor3 = Color3.fromRGB(255, 215, 0)
                bodyColors.RightArmColor3 = Color3.fromRGB(255, 215, 0)
                bodyColors.LeftLegColor3 = Color3.fromRGB(255, 215, 0)
                bodyColors.RightLegColor3 = Color3.fromRGB(255, 215, 0)
            end
        end
    end)
    
    -- Appliquer immédiatement si le personnage existe déjà
    if player.Character then
        player.CharacterAdded:Fire(player.Character)
    end
    
    print("Classe choisie : " .. selectedClass)
    screenGui:Destroy() -- Fermer la GUI
end)

-- Label pour afficher la classe et l'ability
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(0, 400, 0, 100)
infoLabel.Position = UDim2.new(0.5, -200, 1, -120)
infoLabel.Text = "Classe sélectionnée : " .. selectedClass .. "\nAbilité : " .. classes[selectedClass].specialAbility
infoLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
infoLabel.Parent = screenGui

-- Mettre à jour l'info label au changement de classe
while screenGui.Parent do
    wait(0.5)
    if screenGui.Parent then
        infoLabel.Text = "Classe sélectionnée : " .. selectedClass .. "\nAbilité : " .. classes[selectedClass].specialAbility
    end
end