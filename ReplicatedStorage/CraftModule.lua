-- ModuleScript pour le craft (combiner items)
local CraftModule = {}

local recipes = {
    ["Greatsword"] = {["Sword"] = 1, ["Axe"] = 1}, -- Combiner épée + hache
    ["Shield"] = {["Sword"] = 1, ["Potion"] = 2} -- Exemple
}

function CraftModule.CraftItem(player, itemName)
    local recipe = recipes[itemName]
    if recipe then
        local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
        local inv = InventoryModule.GetInventory(player)
        local canCraft = true
        for reqItem, qty in pairs(recipe) do
            if not inv[reqItem] or inv[reqItem] < qty then
                canCraft = false
                break
            end
        end
        if canCraft then
            -- Retirer ingrédients
            for reqItem, qty in pairs(recipe) do
                InventoryModule.UseItem(player, reqItem) -- Utilise qty fois
                for i = 1, qty do
                    InventoryModule.UseItem(player, reqItem)
                end
            end
            -- Ajouter item crafté
            InventoryModule.AddItem(player, itemName, 1)
            return true
        end
    end
    return false
end

return CraftModule