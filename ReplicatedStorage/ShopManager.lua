local ShopManager = {}

-- Module pour gérer le magasin du jeu
-- Permet aux joueurs d'acheter des armes, armures et items avec de l'or

local shopItems = {
    -- Armes
    ["Sword"] = {price = 100, type = "Weapon", description = "Épée basique pour le combat."},
    ["Dagger"] = {price = 150, type = "Weapon", description = "Dague rapide pour les attaques furtives."},
    ["Axe"] = {price = 250, type = "Weapon", description = "Hache puissante pour les dégâts élevés."},
    ["Bow"] = {price = 300, type = "Weapon", description = "Arc pour les attaques à distance."},
    ["Staff"] = {price = 400, type = "Weapon", description = "Bâton magique pour lancer des sorts."},
    ["Spear"] = {price = 350, type = "Weapon", description = "Lance pour les attaques de portée."},
    ["Mace"] = {price = 280, type = "Weapon", description = "Masse pour étourdir les ennemis."},
    ["EnchantedSword"] = {price = 500, type = "Weapon", description = "Épée enchantée avec des dégâts magiques."},
    ["FrostHammer"] = {price = 800, type = "Weapon", description = "Marteau de givre qui gèle les ennemis."},
    ["LightningRapier"] = {price = 1000, type = "Weapon", description = "Rapière de foudre, rapide et électrique."},

    -- Armures
    ["Shield"] = {price = 200, type = "Armor", description = "Bouclier pour réduire les dégâts."},
    ["Helmet"] = {price = 180, type = "Armor", description = "Casque pour protéger la tête."},
    ["Boots"] = {price = 160, type = "Armor", description = "Bottes pour une meilleure mobilité."},
    ["Gloves"] = {price = 140, type = "Armor", description = "Gants pour améliorer la dextérité."},
    ["Chestplate"] = {price = 400, type = "Armor", description = "Plastron pour une défense solide."},
    ["RingOfStrength"] = {price = 600, type = "Armor", description = "Anneau augmentant la force."},
    ["GoldShield"] = {price = 600, type = "Armor", description = "Bouclier doré avec bonus de défense."},
    ["LegendaryArmor"] = {price = 1200, type = "Armor", description = "Armure légendaire offrant une protection maximale."},
    ["ShadowCloak"] = {price = 900, type = "Armor", description = "Cape d'ombre pour la furtivité."},
    ["AmuletOfProtection"] = {price = 750, type = "Armor", description = "Amulette offrant une protection magique."},

    -- Items
    ["Potion"] = {price = 50, type = "Item", description = "Potion de soin pour restaurer 50 HP."},
    ["MegaPotion"] = {price = 150, type = "Item", description = "Potion puissante pour restaurer 150 HP."},
    ["EtherPotion"] = {price = 100, type = "Item", description = "Potion d'éther pour restaurer la mana."},
    ["Bomb"] = {price = 120, type = "Item", description = "Bombe explosive pour endommager les ennemis."},
    ["Key"] = {price = 80, type = "Item", description = "Clé pour ouvrir des portes verrouillées."},
    ["Scroll"] = {price = 90, type = "Item", description = "Parchemin avec des connaissances magiques."},
    ["Elixir"] = {price = 250, type = "Item", description = "Élixir pour restaurer HP et mana."},
    ["Fireball"] = {price = 75, type = "Item", description = "Sort de boule de feu."},
    ["HealSpell"] = {price = 100, type = "Item", description = "Sort de soin."},
    ["ShieldSpell"] = {price = 125, type = "Item", description = "Sort de bouclier temporaire."},
    ["ManaCrystal"] = {price = 200, type = "Item", description = "Cristal de mana pour augmenter la mana max."},
    ["CrystalShard"] = {price = 300, type = "Item", description = "Éclat de cristal pour les crafts."},
    ["PhoenixFeather"] = {price = 500, type = "Item", description = "Plume de phénix pour la résurrection."},
    ["VoidCrystal"] = {price = 700, type = "Item", description = "Cristal du vide pour les sorts avancés."},
    ["EternalCrown"] = {price = 1500, type = "Item", description = "Couronne éternelle, artefact rare."},

    -- Pets
    ["Wolf"] = {price = 300, type = "Pet", description = "Loup fidèle qui attaque les ennemis."},
    ["Raven"] = {price = 200, type = "Pet", description = "Corbeau qui éclaire les zones."},
    ["Golem"] = {price = 500, type = "Pet", description = "Golem robuste qui absorbe les dégâts."},
    ["Eagle"] = {price = 350, type = "Pet", description = "Aigle qui plonge sur les ennemis."},
    ["Bear"] = {price = 600, type = "Pet", description = "Ours puissant qui intimide."},
    ["Dragonling"] = {price = 800, type = "Pet", description = "Petit dragon crachant du feu."},
    ["Phoenix"] = {price = 1500, type = "Pet", description = "Phénix légendaire qui ressuscite."},
    ["ShadowCat"] = {price = 400, type = "Pet", description = "Chat de l'ombre furtif."},
    ["IceFox"] = {price = 450, type = "Pet", description = "Renard de glace qui gèle."},
    ["ThunderBird"] = {price = 700, type = "Pet", description = "Oiseau du tonnerre électrifiant."}
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

    if item.type == "Pet" then
        -- Invoquer le pet
        local PetModule = require(game.ReplicatedStorage.PetModule)
        local success = PetModule.SummonPet(player, itemName)
        if not success then
            return false, "Impossible d'invoquer le pet."
        end
    else
        -- Ajouter l'item à l'inventaire
        local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
        InventoryModule.AddItem(player, itemName, 1)
    end

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