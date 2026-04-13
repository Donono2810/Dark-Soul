-- ModuleScript pour le craft (combiner items)
local CraftModule = {}

local recipes = {
    ["Greatsword"] = {["Sword"] = 1, ["Axe"] = 1},
    ["Shield"] = {["Sword"] = 1, ["Potion"] = 2},
    ["Katana"] = {["Dagger"] = 2, ["Axe"] = 1}, -- Nouvelle arme
    ["Hammer"] = {["Axe"] = 2, ["Greatsword"] = 1}, -- Nouvelle arme
    ["Spear"] = {["Dagger"] = 1, ["Sword"] = 1}, -- Nouvelle arme
    ["Scythe"] = {["Dagger"] = 3, ["Potion"] = 1}, -- Nouvelle arme
    ["Rapier"] = {["Dagger"] = 1} -- Nouvelle arme facile
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