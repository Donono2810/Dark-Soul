-- ModuleScript pour le craft (combiner items)
local CraftModule = {}

local recipes = {
    -- Armes
    ["Greatsword"] = {["Sword"] = 1, ["Axe"] = 1},
    ["Katana"] = {["Dagger"] = 2, ["Axe"] = 1},
    ["Hammer"] = {["Axe"] = 2, ["Greatsword"] = 1},
    ["Spear"] = {["Dagger"] = 1, ["Sword"] = 1},
    ["Scythe"] = {["Dagger"] = 3, ["Potion"] = 1},
    ["Rapier"] = {["Dagger"] = 1},
    
    -- Armures Leather
    ["LeatherHelmet"] = {["Potion"] = 1},
    ["LeatherChest"] = {["Potion"] = 2},
    ["LeatherLegs"] = {["Potion"] = 1},
    ["WoodenShield"] = {["Potion"] = 1, ["Dagger"] = 1},
    
    -- Armures Iron
    ["IronHelmet"] = {["LeatherHelmet"] = 1, ["Sword"] = 1},
    ["IronChest"] = {["LeatherChest"] = 1, ["Axe"] = 1},
    ["IronLegs"] = {["LeatherLegs"] = 1, ["Dagger"] = 1},
    ["IronShield"] = {["WoodenShield"] = 1, ["Axe"] = 1},
    
    -- Armures Gold
    ["GoldHelmet"] = {["IronHelmet"] = 1, ["CrystalShard"] = 2},
    ["GoldChest"] = {["IronChest"] = 1, ["CrystalShard"] = 3},
    ["GoldLegs"] = {["IronLegs"] = 1, ["CrystalShard"] = 2},
    ["GoldShield"] = {["IronShield"] = 1, ["CrystalShard"] = 3},
    
    -- Potions avancées
    ["GreatPotion"] = {["Potion"] = 2, ["Sword"] = 1},
    ["MegaPotion"] = {["GreatPotion"] = 2, ["Axe"] = 1},
    ["EtherPotion"] = {["Potion"] = 1, ["CrystalShard"] = 1},
    ["StaminaPotion"] = {["Potion"] = 2},
    
    -- Sorts avancés
    ["IceSpell"] = {["Fireball"] = 1, ["CrystalShard"] = 1},
    ["LightningBolt"] = {["Fireball"] = 2, ["CrystalShard"] = 2},
    ["HealSpell"] = {["Potion"] = 2, ["CrystalShard"] = 1},
    
    -- Accessoires
    ["AmuletOfStrength"] = {["IronOre"] = 5, ["CrystalShard"] = 2},
    ["RingOfSpeed"] = {["SilverOre"] = 5, ["CrystalShard"] = 1},
    ["AmuletOfProtection"] = {["GoldOre"] = 3, ["CrystalShard"] = 2},
    ["RingOfMana"] = {["CrystalShard"] = 3},
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