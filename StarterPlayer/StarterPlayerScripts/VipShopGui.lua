local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local vipStatusEvent = ReplicatedStorage:WaitForChild("VipStatusUpdated")
local VIP_PRODUCT_ID = 12345678 -- Remplacez par l'ID de votre Developer Product VIP

local isVip = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VipShopGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 160, 0, 40)
toggleButton.Position = UDim2.new(1, -180, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "Boutique VIP"
toggleButton.Parent = screenGui

local shopFrame = Instance.new("Frame")
shopFrame.Size = UDim2.new(0, 300, 0, 200)
shopFrame.Position = UDim2.new(1, -320, 0, 70)
shopFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
shopFrame.BorderSizePixel = 0
shopFrame.Visible = false
shopFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Boutique VIP"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 18
titleLabel.Parent = shopFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0, 40)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 16
statusLabel.Text = "Statut VIP: Non actif"
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = shopFrame

local descriptionLabel = Instance.new("TextLabel")
descriptionLabel.Size = UDim2.new(1, -20, 0, 80)
descriptionLabel.Position = UDim2.new(0, 0, 0, 70)
descriptionLabel.BackgroundTransparency = 1
descriptionLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
descriptionLabel.Font = Enum.Font.SourceSans
descriptionLabel.TextSize = 14
descriptionLabel.Text = "Devenez VIP et obtenez des bonus exclusifs : \n- +20% de dégâts\n- Accès prioritaire aux événements\n- Statut spécial en jeu"
descriptionLabel.TextWrapped = true
descriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
descriptionLabel.Parent = shopFrame

local buyButton = Instance.new("TextButton")
buyButton.Size = UDim2.new(0, 260, 0, 40)
buyButton.Position = UDim2.new(0, 0, 0, 160)
buyButton.BackgroundColor3 = Color3.fromRGB(50, 140, 255)
buyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
buyButton.Font = Enum.Font.SourceSansBold
buyButton.TextSize = 18
buyButton.Text = "Acheter VIP (Robux)"
buyButton.Parent = shopFrame

local function updateStatus(newStatus)
    isVip = newStatus == true
    statusLabel.Text = isVip and "Statut VIP: Actif" or "Statut VIP: Non actif"
    buyButton.Text = isVip and "Déjà VIP" or "Acheter VIP (Robux)"
    buyButton.Active = not isVip
    buyButton.AutoButtonColor = not isVip
end

vipStatusEvent.OnClientEvent:Connect(updateStatus)

toggleButton.MouseButton1Click:Connect(function()
    shopFrame.Visible = not shopFrame.Visible
end)

buyButton.MouseButton1Click:Connect(function()
    if isVip then
        return
    end
    MarketplaceService:PromptProductPurchase(player, VIP_PRODUCT_ID)
end)

-- Initialiser l'état local si le serveur n'a pas encore envoyé l'info
updateStatus(false)
