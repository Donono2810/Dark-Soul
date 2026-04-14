-- LocalScript pour l'interface du magasin
local ShopManager = require(game.ReplicatedStorage.ShopManager)
local player = game.Players.LocalPlayer

-- Créer la GUI du magasin
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShopGui"
screenGui.Parent = player.PlayerGui

-- Fond du magasin
local shopFrame = Instance.new("Frame")
shopFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
shopFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
shopFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
shopFrame.BackgroundTransparency = 0.2
shopFrame.Visible = false
shopFrame.Parent = screenGui

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Magasin"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.TextScaled = true
title.Parent = shopFrame

-- Bouton fermer
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = shopFrame

closeButton.MouseButton1Click:Connect(function()
    shopFrame.Visible = false
end)

-- ScrollFrame pour les items
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 0.8, 0)
scrollFrame.Position = UDim2.new(0, 0, 0.1, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Sera ajusté
scrollFrame.Parent = shopFrame

-- Fonction pour créer un bouton d'item
local function createItemButton(itemName, itemData, yPos)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 50)
    button.Position = UDim2.new(0.05, 0, 0, yPos)
    button.Text = itemName .. " - " .. itemData.price .. " or\n" .. itemData.description
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextWrapped = true
    button.Parent = scrollFrame

    button.MouseButton1Click:Connect(function()
        -- Appeler la fonction d'achat sur le serveur
        local success, message = game.ReplicatedStorage.BuyItemRemote:InvokeServer("BuyItem", itemName)
        if success then
            button.Text = "Acheté !"
            wait(2)
            button.Text = itemName .. " - " .. itemData.price .. " or\n" .. itemData.description
        else
            local errorLabel = Instance.new("TextLabel")
            errorLabel.Size = UDim2.new(1, 0, 0, 30)
            errorLabel.Position = UDim2.new(0, 0, 1, 0)
            errorLabel.Text = message
            errorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            errorLabel.BackgroundTransparency = 1
            errorLabel.Parent = button
            wait(3)
            errorLabel:Destroy()
        end
    end)

    return button.Size.Y.Offset + 10
end

-- Remplir le scrollFrame avec les items
local shopItems = ShopManager.GetShopItems()
local yOffset = 0
for itemName, itemData in pairs(shopItems) do
    yOffset = yOffset + createItemButton(itemName, itemData, yOffset)
end
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)

-- Fonction pour ouvrir le magasin
function openShop()
    shopFrame.Visible = true
end

-- Exposer la fonction pour être appelée depuis un script serveur
game.ReplicatedStorage:WaitForChild("OpenShop").OnClientEvent:Connect(openShop)