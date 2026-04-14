local NPCShopsModule = {}

-- Module pour échoppes NPC interactives
NPCShopsModule.Shops = {
    Blacksmith = {Items = {"Sword", "Armor"}, Prices = {100, 200}}
}

-- Fonction pour acheter
function NPCShopsModule.BuyItem(player, shopName, itemIndex)
    local shop = NPCShopsModule.Shops[shopName]
    if shop and player:GetAttribute("Gold") >= shop.Prices[itemIndex] then
        player:SetAttribute("Gold", player:GetAttribute("Gold") - shop.Prices[itemIndex])
        -- Ajouter item
    end
end

return NPCShopsModule