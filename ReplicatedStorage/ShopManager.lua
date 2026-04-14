local ShopManager = {}

-- Module pour gérer le magasin du jeu
-- Permet aux joueurs d'acheter des armes, armures et items avec de l'or

local shopItems = {
    -- Armes
    ["Sword"] = {price = 100, type = "Weapon", description = "Épée basique pour le combat."},
    ["Dagger"] = {price = 150, type = "Weapon", description = "Dague rapide pour les attaques furtives."},
    ["EnchantedSword"] = {price = 500, type = "Weapon", description = "Épée enchantée avec des dégâts magiques."},
    ["FrostHammer"] = {price = 800, type = "Weapon", description = "Marteau de givre qui gèle les ennemis."},
    ["LightningRapier"] = {price = 1000, type = "Weapon", description = "Rapière de foudre, rapide et électrique."},

    -- Armures
    ["Shield"] = {price = 200, type = "Armor", description = "Bouclier pour réduire les dégâts."},
    ["GoldShield"] = {price = 600, type = "Armor", description = "Bouclier doré avec bonus de défense."},
    ["LegendaryArmor"] = {price = 1200, type = "Armor", description = "Armure légendaire offrant une protection maximale."},
    ["ShadowCloak"] = {price = 900, type = "Armor", description = "Cape d'ombre pour la furtivité."},

    -- Items
    ["Potion"] = {price = 50, type = "Item", description = "Potion de soin pour restaurer 50 HP."},
    ["MegaPotion"] = {price = 150, type = "Item", description = "Potion puissante pour restaurer 150 HP."},
    ["EtherPotion"] = {price = 100, type = "Item", description = "Potion d'éther pour restaurer la mana."},
    ["Fireball"] = {price = 75, type = "Item", description = "Sort de boule de feu."},
    ["HealSpell"] = {price = 100, type = "Item", description = "Sort de soin."},
    ["ShieldSpell"] = {price = 125, type = "Item", description = "Sort de bouclier temporaire."},
    ["ManaCrystal"] = {price = 200, type = "Item", description = "Cristal de mana pour augmenter la mana max."},
    ["CrystalShard"] = {price = 300, type = "Item", description = "Éclat de cristal pour les crafts."},
    ["PhoenixFeather"] = {price = 500, type = "Item", description = "Plume de phénix pour la résurrection."},
    ["VoidCrystal"] = {price = 700, type = "Item", description = "Cristal du vide pour les sorts avancés."},
    ["EternalCrown"] = {price = 1500, type = "Item", description = "Couronne éternelle, artefact rare."}
}

-- Fonction pour obtenir la liste des items du magasin
function ShopManager.GetShopItems()
    return shopItems
end

-- Fonction pour acheter un item
function ShopManager.BuyItem(player, itemName)
    local item = shopItems[itemName]
    if not item then
        return false, "Item non trouvé."
    end

    local playerData = player:FindFirstChild("PlayerData")
    if not playerData then
        return false, "Données joueur introuvables."
    end

    local gold = playerData:FindFirstChild("Gold")
    if not gold or gold.Value < item.price then
        return false, "Or insuffisant."
    end

    -- Déduire l'or
    gold.Value = gold.Value - item.price

    -- Ajouter l'item à l'inventaire
    local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
    InventoryModule.AddItem(player, itemName, 1)

    -- Notification
    local notification = Instance.new("Hint")
    notification.Text = "Acheté : " .. itemName .. " pour " .. item.price .. " or."
    notification.Parent = player.PlayerGui
    wait(3)
    notification:Destroy()

    print(player.Name .. " a acheté " .. itemName)
    return true, "Achat réussi !"
end

return ShopManager