-- Script serveur pour gérer les achats VIP avec Robux
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local VipModule = require(game.ReplicatedStorage.VipModule)

local VIP_PRODUCT_ID = 12345678 -- Remplacez par l'ID de votre Developer Product VIP

Players.PlayerAdded:Connect(function(player)
    VipModule.LoadPlayer(player)
end)

Players.PlayerRemoving:Connect(function(player)
    VipModule.SavePlayer(player)
end)

MarketplaceService.ProcessReceipt = function(receiptInfo)
    if receiptInfo.ProductId == VIP_PRODUCT_ID then
        local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
        if player then
            VipModule.SetVip(player, true)
        end
        return Enum.ProductPurchaseDecision.PurchaseGranted
    end
    return Enum.ProductPurchaseDecision.NotProcessedYet
end
