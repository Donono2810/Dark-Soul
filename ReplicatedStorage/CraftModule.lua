-- ModuleScript pour le craft (combiner items)
local CraftModule = {}

local recipes = {
    ["Greatsword"] = {["Sword"] = 1, ["Axe"] = 1},
    ["Shield"] = {["Sword"] = 1, ["Potion"] = 2},
    ["Katana"] = {["Dagger"] = 2, ["Axe"] = 1}, -- Nouvelle arme
    ["Hammer"] = {["Axe"] = 2, ["Greatsword"] = 1}, -- Nouvelle arme
    ["Spear"] = {["Dagger"] = 1, ["Sword"] = 1}, -- Nouvelle arme
    ["Scythe"] = {["Dagger"] = 3, ["Potion"] = 1}, -- Nouvelle arme
    ["Rapier"] = {["Dagger"] = 1}, -- Nouvelle arme facile
    -- Armures
    ["LeatherHelmet"] = {["Potion"] = 1},
    ["LeatherChest"] = {["Potion"] = 2},
    ["LeatherLegs"] = {["Potion"] = 1},
    ["WoodenShield"] = {["Potion"] = 1, ["Dagger"] = 1},
    ["IronHelmet"] = {["LeatherHelmet"] = 1, ["Sword"] = 1},
    ["IronChest"] = {["LeatherChest"] = 1, ["Axe"] = 1},
    ["IronLegs"] = {["LeatherLegs"] = 1, ["Dagger"] = 1},
    ["IronShield"] = {["WoodenShield"] = 1, ["Axe"] = 1}
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