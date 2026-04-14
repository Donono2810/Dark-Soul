-- Script pour gérer les événements du magasin côté serveur
local ShopManager = require(game.ReplicatedStorage.ShopManager)

-- RemoteFunction pour acheter des items
local buyItemRemote = Instance.new("RemoteFunction")
buyItemRemote.Name = "BuyItemRemote"
buyItemRemote.Parent = game.ReplicatedStorage

buyItemRemote.OnServerInvoke = function(player, action, itemName)
    if action == "BuyItem" then
        return ShopManager.BuyItem(player, itemName)
    end
end

-- RemoteEvent pour ouvrir le magasin
local openShopRemote = Instance.new("RemoteEvent")
openShopRemote.Name = "OpenShop"
openShopRemote.Parent = game.ReplicatedStorage

-- Fonction pour ouvrir le magasin (appelée depuis un script serveur)
function openShopForPlayer(player)
    openShopRemote:FireClient(player)
end

-- Exposer la fonction
_G.OpenShopForPlayer = openShopForPlayer