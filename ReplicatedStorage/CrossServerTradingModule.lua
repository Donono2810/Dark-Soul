local CrossServerTradingModule = {}

-- Module pour commerce inter-serveurs
CrossServerTradingModule.GlobalMarket = {} -- Stockage partagé

-- Fonction pour lister un item
function CrossServerTradingModule.ListItem(player, item, price)
    table.insert(CrossServerTradingModule.GlobalMarket, {Seller = player, Item = item, Price = price})
end

-- Fonction pour acheter
function CrossServerTradingModule.BuyItem(player, listingId)
    local listing = CrossServerTradingModule.GlobalMarket[listingId]
    if listing and player:GetAttribute("Gold") >= listing.Price then
        -- Transférer item et or
    end
end

return CrossServerTradingModule