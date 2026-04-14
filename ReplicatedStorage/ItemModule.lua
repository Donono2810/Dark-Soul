-- ModuleScript pour gérer tous les items avec leurs stats
local ItemModule = {}

local items = {
    -- Armes
    ["Sword"] = {type = "weapon", damage = 20, speed = 1.5, crit = 5, description = "Épée équilibrée"},
    ["Axe"] = {type = "weapon", damage = 35, speed = 2.0, crit = 10, description = "Hache puissante mais lente"},
    ["Dagger"] = {type = "weapon", damage = 15, speed = 1.0, crit = 15, description = "Dague rapide et légère"},
    ["Greatsword"] = {type = "weapon", damage = 50, speed = 2.5, crit = 8, description = "Très lente mais dévastateur"},
    ["Bow"] = {type = "weapon", damage = 25, speed = 1.2, crit = 12, ranged = true, description = "Arc à distance"},
    ["Katana"] = {type = "weapon", damage = 45, speed = 1.3, crit = 20, description = "Rapide et forte avec crit élevé"},
    ["Hammer"] = {type = "weapon", damage = 60, speed = 3.0, crit = 5, stun = 10, description = "Très puissante, peut stunner"},
    ["Spear"] = {type = "weapon", damage = 30, speed = 1.4, crit = 8, reach = 2, description = "Allongée et équilibrée"},
    ["Scythe"] = {type = "weapon", damage = 55, speed = 2.3, crit = 18, lifesteal = 10, description = "Elle régénère de la vie"},
    ["Rapier"] = {type = "weapon", damage = 18, speed = 0.8, crit = 25, description = "Ultra-rapide avec crit très élevé"},
    
    -- Armures Leather
    ["LeatherHelmet"] = {type = "armor", slot = "helmet", defense = 5, dodge = 2, description = "Casque en cuir léger"},
    ["LeatherChest"] = {type = "armor", slot = "chest", defense = 10, dodge = 1, description = "Plastron en cuir"},
    ["LeatherLegs"] = {type = "armor", slot = "legs", defense = 8, speed_bonus = 1, description = "Jambières en cuir"},
    ["WoodenShield"] = {type = "armor", slot = "shield", defense = 15, block = 20, description = "Bouclier en bois"},
    
    -- Armures Iron
    ["IronHelmet"] = {type = "armor", slot = "helmet", defense = 10, dodge = 0, description = "Casque en fer robuste"},
    ["IronChest"] = {type = "armor", slot = "chest", defense = 20, dodge = -1, description = "Plastron en fer lourd"},
    ["IronLegs"] = {type = "armor", slot = "legs", defense = 15, speed_bonus = -1, description = "Jambières en fer épaisses"},
    ["IronShield"] = {type = "armor", slot = "shield", defense = 25, block = 35, description = "Bouclier en fer massif"},
    
    -- Armures Gold (premium)
    ["GoldHelmet"] = {type = "armor", slot = "helmet", defense = 15, dodge = 3, mana_regen = 5, description = "Casque doré magique"},
    ["GoldChest"] = {type = "armor", slot = "chest", defense = 28, dodge = 1, health_regen = 2, description = "Plastron doré enchanteur"},
    ["GoldLegs"] = {type = "armor", slot = "legs", defense = 20, speed_bonus = 2, description = "Jambières dorées légères"},
    ["GoldShield"] = {type = "armor", slot = "shield", defense = 35, block = 50, reflection = 10, description = "Bouclier doré réfléchissant"},
    
    -- Potions
    ["Potion"] = {type = "consumable", healing = 30, description = "Potion de soin basique"},
    ["GreatPotion"] = {type = "consumable", healing = 60, description = "Potion de soin avancée"},
    ["MegaPotion"] = {type = "consumable", healing = 100, description = "Potion de soin puissante"},
    ["EtherPotion"] = {type = "consumable", mana_restore = 50, description = "Restaure la mana"},
    ["AntidotePotion"] = {type = "consumable", cure = "poison", description = "Élimine le poison"},
    ["StaminaPotion"] = {type = "consumable", stamina_restore = 50, description = "Restaure la stamina"},
    
    -- Sorts
    ["Fireball"] = {type = "spell", damage = 40, mana = 30, description = "Lance une boule de feu"},
    ["IceSpell"] = {type = "spell", damage = 35, mana = 25, stun = 5, description = "Gèle l'ennemi"},
    ["LightningBolt"] = {type = "spell", damage = 50, mana = 35, crit = 20, description = "Éclair puissant"},
    ["HealSpell"] = {type = "spell", healing = 40, mana = 30, description = "Sort de soin"},
    ["ShieldSpell"] = {type = "spell", defense_buff = 20, mana = 25, duration = 10, description = "Bouclier magique"},
    
    -- Matériaux
    ["IronOre"] = {type = "material", rarity = "common", description = "Minerai de fer brut"},
    ["GoldOre"] = {type = "material", rarity = "rare", description = "Minerai d'or rare"},
    ["SilverOre"] = {type = "material", rarity = "uncommon", description = "Minerai d'argent"},
    ["CrystalShard"] = {type = "material", rarity = "legendary", description = "Fragment de cristal magique"},
    ["DragonScale"] = {type = "material", rarity = "epic", description = "Écaille de dragon"},
    
    -- Accessoires
    ["AmuletOfStrength"] = {type = "accessory", damage_bonus = 15, description = "Amulette renforçant l'attaque"},
    ["RingOfSpeed"] = {type = "accessory", speed_bonus = 3, description = "Anneau augmentant la vitesse"},
    ["AmuletOfProtection"] = {type = "accessory", defense_bonus = 10, description = "Amulette renforçant la défense"},
    ["RingOfMana"] = {type = "accessory", mana_bonus = 50, mana_regen = 5, description = "Anneau du mage"},
}

function ItemModule.GetItemStats(itemName)
    return items[itemName] or {type = "unknown", description = "Item inconnu"}
end

function ItemModule.GetAllItems()
    return items
end

function ItemModule.IsConsumable(itemName)
    local item = items[itemName]
    return item and item.type == "consumable"
end

function ItemModule.IsEquippable(itemName)
    local item = items[itemName]
    return item and (item.type == "weapon" or item.type == "armor" or item.type == "accessory")
end

return ItemModule