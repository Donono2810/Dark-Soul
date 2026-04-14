-- ModuleScript pour les quêtes (multiples par zone)
local QuestModule = {}

local playerQuests = {} -- Quêtes actives par joueur

local questData = {
    -- Quêtes de combat
    ["KillEnemies"] = {required = 5, reward = {["Potion"] = 2, ["Axe"] = 1}, description = "Tuer 5 ennemis basiques"},
    ["KillGoblins"] = {required = 10, reward = {["Dagger"] = 1, ["Potion"] = 3}, description = "Éliminer 10 gobelins"},
    ["KillOrcs"] = {required = 5, reward = {["Greatsword"] = 1}, description = "Vaincre 5 orcs sauvages"},
    ["KillSkeletons"] = {required = 15, reward = {["Scythe"] = 1}, description = "Détruire 15 squelettes"},
    ["KillBosses"] = {required = 3, reward = {["PhoenixPotion"] = 1}, description = "Tuer 3 boss"},

    -- Quêtes de collecte
    ["CollectBones"] = {required = 20, reward = {["ShieldSpell"] = 2}, description = "Collecter 20 os de squelettes"},
    ["CollectCrystals"] = {required = 10, reward = {["CrystalShard"] = 5}, description = "Rassembler 10 cristaux magiques"},
    ["CollectHerbs"] = {required = 15, reward = {["EtherPotion"] = 3}, description = "Récolter 15 herbes médicinales"},
    ["CollectOres"] = {required = 25, reward = {["IronOre"] = 10}, description = "Miner 25 minerais"},

    -- Quêtes d'exploration
    ["ExploreZone1"] = {required = 1, reward = {["Sword"] = 1}, description = "Explorer complètement la Zone 1"},
    ["ExploreZone2"] = {required = 1, reward = {["Fireball"] = 5}, description = "Découvrir les secrets de la Zone 2"},
    ["ExploreZone3"] = {required = 1, reward = {["HealSpell"] = 3}, description = "Cartographier la Zone 3"},
    ["ExploreZone4"] = {required = 1, reward = {["LightningBolt"] = 2}, description = "Explorer les cavernes de la Zone 4"},
    ["FindHiddenTreasure"] = {required = 5, reward = {["GoldOre"] = 5}, description = "Trouver 5 trésors cachés"},

    -- Quêtes sociales
    ["RecruitAllies"] = {required = 3, reward = {["AmuletOfStrength"] = 1}, description = "Recruter 3 alliés PNJ"},
    ["JoinFaction"] = {required = 1, reward = {["RingOfSpeed"] = 1}, description = "Rejoindre une faction"},
    ["CreateGuild"] = {required = 1, reward = {["RingOfMana"] = 1}, description = "Fonder une guilde"},
    ["WinGuildBattle"] = {required = 2, reward = {["DivineShield"] = 1}, description = "Gagner 2 batailles de guilde"},

    -- Quêtes spéciales
    ["CraftLegendaryWeapon"] = {required = 1, reward = {["EnchantedSword"] = 1}, description = "Forger une arme légendaire"},
    ["TamePet"] = {required = 1, reward = {["Wolf"] = 1}, description = "Apprivoiser un compagnon animal"},
    ["CompleteDailyChallenge"] = {required = 7, reward = {["MegaPotion"] = 5}, description = "Terminer 7 défis quotidiens"},
    ["SurviveWaves"] = {required = 10, reward = {["ManaCrystal"] = 1}, description = "Survivre à 10 vagues en mode Survie"},

    -- Quêtes narratives (liées au mode histoire)
    ["SaveVillager"] = {required = 1, reward = {["Potion"] = 5}, description = "Sauver un villageois en détresse"},
    ["SolveRiddle"] = {required = 3, reward = {["CrystalShard"] = 3}, description = "Résoudre 3 énigmes anciennes"},
    ["DefeatAncientGuardian"] = {required = 1, reward = {["DragonScale"] = 5}, description = "Vaincre le Gardien Ancien"},
    ["UniteFactions"] = {required = 3, reward = {["AmuletOfProtection"] = 1}, description = "Unir 3 factions rivales"},
    ["PurifyLand"] = {required = 5, reward = {["HealSpell"] = 5}, description = "Purifier 5 zones corrompues"},
    ["CollectArtifacts"] = {required = 7, reward = {["FrostHammer"] = 1}, description = "Rassembler 7 artefacts sacrés"},
    ["TrainApprentice"] = {required = 1, reward = {["Fireball"] = 10}, description = "Former un apprenti magicien"},
    ["BuildFortress"] = {required = 1, reward = {["GoldShield"] = 1}, description = "Construire une forteresse"},
    ["NegotiatePeace"] = {required = 2, reward = {["EtherPotion"] = 10}, description = "Négocier la paix entre 2 groupes"},
    ["AwakenAncientPower"] = {required = 1, reward = {["LightningRapier"] = 1}, description = "Éveiller un pouvoir ancien"}
}

function QuestModule.StartQuest(player, questName)
    if not playerQuests[player.UserId] then
        playerQuests[player.UserId] = {}
    end
    if questData[questName] then
        playerQuests[player.UserId][questName] = {progress = 0, required = questData[questName].required}
    end
end

function QuestModule.UpdateQuest(player, questName, amount)
    if playerQuests[player.UserId] and playerQuests[player.UserId][questName] then
        playerQuests[player.UserId][questName].progress = playerQuests[player.UserId][questName].progress + amount
        if playerQuests[player.UserId][questName].progress >= playerQuests[player.UserId][questName].required then
            -- Récompense
            local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
            for item, qty in pairs(questData[questName].reward) do
                InventoryModule.AddItem(player, item, qty)
            end
            playerQuests[player.UserId][questName] = nil -- Terminer quête
            print("Quête " .. questName .. " terminée ! Récompenses ajoutées.")
        end
    end
end

function QuestModule.GetAvailableQuests()
    local available = {}
    for name, data in pairs(questData) do
        table.insert(available, {name = name, description = data.description, required = data.required})
    end
    return available
end

function QuestModule.GetQuestDescription(questName)
    return questData[questName] and questData[questName].description or "Quête inconnue"
end

function QuestModule.GetQuestReward(questName)
    return questData[questName] and questData[questName].reward or {}
end