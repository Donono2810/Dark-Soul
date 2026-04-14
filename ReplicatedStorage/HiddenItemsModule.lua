local HiddenItemsModule = {}

-- Module pour gérer les items cachés dans le monde
-- Les items sont des objets cachés que les joueurs peuvent trouver et collecter

local hiddenItems = {
    -- Zone 1
    ["AncientCoin"] = {
        zone = 1,
        position = Vector3.new(50, 0, 50),
        reward = {["Gold"] = 50, ["Experience"] = 100},
        description = "Une pièce ancienne cachée derrière un rocher.",
        model = "Coin" -- Nom du modèle dans ReplicatedStorage
    },
    ["MysticHerb"] = {
        zone = 1,
        position = Vector3.new(-30, 0, 30),
        reward = {["Potion"] = 1},
        description = "Une herbe mystique poussant dans un coin sombre.",
        model = "Herb"
    },

    -- Zone 2
    ["LostRing"] = {
        zone = 2,
        position = Vector3.new(100, 0, 100),
        reward = {["RingOfStrength"] = 1},
        description = "Un anneau perdu sous un pont.",
        model = "Ring"
    },
    ["CrystalFragment"] = {
        zone = 2,
        position = Vector3.new(80, 0, -50),
        reward = {["CrystalShard"] = 3},
        description = "Un fragment de cristal brillant caché dans les buissons.",
        model = "Crystal"
    },

    -- Zone 3
    ["EnchantedSword"] = {
        zone = 3,
        position = Vector3.new(200, 0, 200),
        reward = {["EnchantedSword"] = 1},
        description = "Une épée enchantée enterrée près d'un arbre.",
        model = "Sword"
    },
    ["TreasureChest"] = {
        zone = 3,
        position = Vector3.new(180, 0, -100),
        reward = {["Gold"] = 200, ["Potion"] = 2},
        description = "Un coffre au trésor caché derrière une cascade.",
        model = "Chest"
    },

    -- Zone 4
    ["DragonEgg"] = {
        zone = 4,
        position = Vector3.new(350, 0, 350),
        reward = {["DragonEgg"] = 1},
        description = "Un œuf de dragon caché dans un nid.",
        model = "Egg"
    },
    ["MagicScroll"] = {
        zone = 4,
        position = Vector3.new(320, 0, -150),
        reward = {["Fireball"] = 5},
        description = "Un parchemin magique roulé sous une pierre.",
        model = "Scroll"
    },

    -- Zone 5
    ["LegendaryArmor"] = {
        zone = 5,
        position = Vector3.new(500, 0, 500),
        reward = {["LegendaryArmor"] = 1},
        description = "Une armure légendaire cachée dans une grotte.",
        model = "Armor"
    },
    ["PhoenixFeather"] = {
        zone = 5,
        position = Vector3.new(480, 0, -200),
        reward = {["PhoenixFeather"] = 1},
        description = "Une plume de phénix flottant près d'un lac.",
        model = "Feather"
    },

    -- Zone 6
    ["CrystalKey"] = {
        zone = 6,
        position = Vector3.new(650, 0, 650),
        reward = {["CrystalKey"] = 1},
        description = "Une clé de cristal cachée dans les cristaux.",
        model = "Key"
    },
    ["ManaOrb"] = {
        zone = 6,
        position = Vector3.new(630, 0, -250),
        reward = {["ManaCrystal"] = 2},
        description = "Une orbe de mana pulsant dans l'ombre.",
        model = "Orb"
    },

    -- Zone 7
    ["LavaGem"] = {
        zone = 7,
        position = Vector3.new(750, 0, 750),
        reward = {["LavaGem"] = 1},
        description = "Un gemme de lave chaude près d'un volcan.",
        model = "Gem"
    },
    ["FireEssence"] = {
        zone = 7,
        position = Vector3.new(730, 0, -300),
        reward = {["Fireball"] = 10},
        description = "Une essence de feu contenue dans une bouteille.",
        model = "Bottle"
    },

    -- Zone 8
    ["ShadowCloak"] = {
        zone = 8,
        position = Vector3.new(800, 0, 800),
        reward = {["ShadowCloak"] = 1},
        description = "Une cape d'ombre cachée dans les ténèbres.",
        model = "Cloak"
    },
    ["VoidCrystal"] = {
        zone = 8,
        position = Vector3.new(780, 0, -350),
        reward = {["VoidCrystal"] = 1},
        description = "Un cristal du vide flottant mystérieusement.",
        model = "Crystal"
    },

    -- Donjon Secret
    ["EternalRelic"] = {
        zone = "SecretDungeon",
        position = Vector3.new(850, 0, 850),
        reward = {["EternalCrown"] = 1},
        description = "Une relique éternelle au cœur du donjon secret.",
        model = "Relic"
    }
}

-- Fonction pour obtenir les items d'une zone
function HiddenItemsModule.GetItemsForZone(zone)
    local items = {}
    for name, data in pairs(hiddenItems) do
        if data.zone == zone then
            table.insert(items, {name = name, data = data})
        end
    end
    return items
end

-- Fonction pour donner la récompense à un joueur
function HiddenItemsModule.GiveReward(player, itemName)
    local item = hiddenItems[itemName]
    if not item then return end

    local playerData = player:FindFirstChild("PlayerData")
    if not playerData then return end

    -- Ajouter les récompenses à l'inventaire du joueur
    for rewardType, amount in pairs(item.reward) do
        if playerData:FindFirstChild(rewardType) then
            playerData[rewardType].Value = playerData[rewardType].Value + amount
        else
            local valueObj = Instance.new("IntValue")
            valueObj.Name = rewardType
            valueObj.Value = amount
            valueObj.Parent = playerData
        end
    end

    -- Notification au joueur
    local notification = Instance.new("Hint")
    notification.Text = "Vous avez trouvé : " .. item.description .. " Récompense : " .. table.concat(item.reward, ", ")
    notification.Parent = player.PlayerGui
    wait(3)
    notification:Destroy()

    print(player.Name .. " a collecté l'item caché : " .. itemName)
end

return HiddenItemsModule