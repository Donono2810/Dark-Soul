local ItemRecyclingModule = {}

-- Module pour recyclage d'items
ItemRecyclingModule.Recipe = {
    Sword = {Materials = {"Iron", 2}, Gold = 50}
}

-- Fonction pour recycler
function ItemRecyclingModule.RecycleItem(player, itemName)
    local recipe = ItemRecyclingModule.Recipe[itemName]
    if recipe then
        -- Retirer item, ajouter matériaux et or
    end
end

return ItemRecyclingModule