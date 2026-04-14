local LoreItemsModule = {}

-- Module pour indices et lore
LoreItemsModule.Items = {
    AncientScroll = {Lore = "The dark lord rises...", QuestUnlock = "MainQuest"}
}

-- Fonction pour collecter un item de lore
function LoreItemsModule.CollectLoreItem(player, itemName)
    local item = LoreItemsModule.Items[itemName]
    if item then
        -- Ajouter à collection, révéler lore
    end
end

return LoreItemsModule