-- ModuleScript pour le mode Histoire avec cinématiques
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local StoryMode = {}
local storyChapters = {
    [1] = {
        title = "L'Arrivée dans les Terres Maudites",
        cinematic = function(player)
            local camera = workspace.CurrentCamera
            local char = player.Character
            if not char then return end

            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = CFrame.new(Vector3.new(0, 10, -20), Vector3.new(0, 0, 0))

            local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(camera, tweenInfo, {CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 5, -10)})
            tween:Play()
            tween.Completed:Wait()

            StoryMode.ShowDialogue("Narrateur", "Bienvenue dans les Terres Maudites. Votre quête commence ici.")
            wait(3)
            StoryMode.ShowDialogue("Narrateur", "Affrontez les ennemis et progressez dans les zones.")
            wait(3)

            camera.CameraType = Enum.CameraType.Custom
        end,
        objectives = {"Tuer 5 ennemis", "Explorer Zone 1"},
        sideQuests = {"CollectHerbs", "SaveVillager", "RecruitAllies"},
        reward = {exp = 200, item = "Sword"}
    },
    [2] = {
        title = "Le Premier Boss",
        cinematic = function(player)
            StoryMode.ShowDialogue("Ancien", "Le boss vous attend. Préparez-vous !")
            wait(2)
            StoryMode.ShowDialogue("Ancien", "Utilisez vos compétences avec sagesse.")
            wait(2)
        end,
        objectives = {"Tuer le Boss Zone 1"},
        sideQuests = {"SolveRiddle", "FindHiddenTreasure", "CraftLegendaryWeapon"},
        reward = {exp = 500, item = "Greatsword"}
    },
    [3] = {
        title = "Les Profondeurs Sombres",
        cinematic = function(player)
            local camera = workspace.CurrentCamera
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = CFrame.new(Vector3.new(100, 20, 0), Vector3.new(100, 0, 0))
            wait(3)
            camera.CameraType = Enum.CameraType.Custom
            StoryMode.ShowDialogue("Narrateur", "Les profondeurs cachent des secrets anciens.")
            wait(3)
        end,
        objectives = {"Explorer Zone 2", "Tuer 10 ennemis"},
        sideQuests = {"CollectCrystals", "ExploreZone2", "DefeatAncientGuardian"},
        reward = {exp = 800, item = "IceSpell"}
    },
    [4] = {
        title = "L'Alliance des Factions",
        cinematic = function(player)
            StoryMode.ShowChoice(player, "Choisissez une faction :", {"Chevaliers", "Sorciers", "Mercenaires"}, function(choice)
                require(game.ReplicatedStorage.ReputationModule).SetFaction(player, choice)
                StoryMode.ShowDialogue("Narrateur", "Vous avez rejoint les " .. choice .. ".")
                wait(2)
            end)
        end,
        objectives = {"Rejoindre une faction", "Compléter une quête de faction"},
        sideQuests = {"JoinFaction", "UniteFactions", "NegotiatePeace"},
        reward = {exp = 1000, item = "AmuletOfStrength"}
    },
    [5] = {
        title = "Le Raid des Goblins",
        cinematic = function(player)
            StoryMode.ShowDialogue("Chef Goblin", "Vous osez entrer dans notre territoire ?!")
            wait(2)
            StoryMode.ShowDialogue("Narrateur", "Un raid massif commence.")
            wait(2)
        end,
        objectives = {"Tuer 20 Goblins", "Détruire leur camp"},
        sideQuests = {"KillGoblins", "CollectOres", "TrainApprentice"},
        reward = {exp = 1200, item = "Hammer"}
    },
    [6] = {
        title = "Les Orcs Sauvages",
        cinematic = function(player)
            local camera = workspace.CurrentCamera
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = CFrame.new(Vector3.new(200, 15, 50), Vector3.new(200, 0, 50))
            wait(4)
            camera.CameraType = Enum.CameraType.Custom
        end,
        objectives = {"Tuer le Chef Orc", "Explorer les cavernes"},
        sideQuests = {"KillOrcs", "CollectBones", "TamePet"},
        reward = {exp = 1500, item = "Katana"}
    },
    [7] = {
        title = "L'Invasion des Squelettes",
        cinematic = function(player)
            StoryMode.ShowDialogue("Nécromancien", "Les morts se relèvent !")
            wait(3)
            StoryMode.ShowDialogue("Narrateur", "Une armée de squelettes envahit le monde.")
            wait(3)
        end,
        objectives = {"Tuer 30 Squelettes", "Détruire le tombeau"},
        sideQuests = {"KillSkeletons", "PurifyLand", "AwakenAncientPower"},
        reward = {exp = 1800, item = "Scythe"}
    },
    [8] = {
        title = "Le Dragon Ancien",
        cinematic = function(player)
            local camera = workspace.CurrentCamera
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = CFrame.new(Vector3.new(300, 50, 100), Vector3.new(300, 0, 100))
            wait(5)
            camera.CameraType = Enum.CameraType.Custom
            StoryMode.ShowDialogue("Dragon", "Qui ose me défier ?")
            wait(3)
        end,
        objectives = {"Tuer le Dragon", "Récupérer l'œuf"},
        sideQuests = {"CollectArtifacts", "BuildFortress", "CompleteDailyChallenge"},
        reward = {exp = 2500, item = "PhoenixPotion"}
    },
    [9] = {
        title = "La Guerre des Guildes",
        cinematic = function(player)
            StoryMode.ShowDialogue("Chef de Guilde", "Les guildes se font la guerre ! Choisissez votre camp.")
            wait(3)
            StoryMode.ShowChoice(player, "Rejoindre une guilde :", {"Guilde des Héros", "Guilde des Ténèbres"}, function(choice)
                require(game.ReplicatedStorage.GuildModule).CreateGuild(choice, player)
                StoryMode.ShowDialogue("Narrateur", "Vous avez fondé la " .. choice .. ".")
                wait(2)
            end)
        end,
        objectives = {"Gagner 1000 points de guilde", "Vaincre une guilde rivale"},
        sideQuests = {"CreateGuild", "WinGuildBattle", "SurviveWaves"},
        reward = {exp = 3000, item = "DivineShield"}
    },
    [10] = {
        title = "Le Finale Épique",
        cinematic = function(player)
            local camera = workspace.CurrentCamera
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = CFrame.new(Vector3.new(0, 100, 0), Vector3.new(0, 0, 0))
            wait(7)
            camera.CameraType = Enum.CameraType.Custom
            StoryMode.ShowDialogue("Dieu Suprême", "Votre destin s'accomplit.")
            wait(4)
        end,
        objectives = {"Tuer le Boss Final", "Sauver le monde"},
        sideQuests = {"KillBosses", "CollectArtifacts", "AwakenAncientPower"},
        reward = {exp = 5000, item = "EnchantedSword"}
    }
}

local playerProgress = {}

function StoryMode.StartChapter(player, chapterId)
    local chapter = storyChapters[chapterId]
    if not chapter then return end

    playerProgress[player.UserId] = {chapter = chapterId, objectives = {}, sideQuests = {}}

    -- Jouer la cinématique
    chapter.cinematic(player)

    -- Téléporter à la zone
    local zone = workspace:FindFirstChild("Zone" .. chapterId)
    if zone and zone:FindFirstChild("Spawn") then
        player.Character.HumanoidRootPart.CFrame = zone.Spawn.CFrame
    end

    -- Événement aléatoire
    if math.random(1, 10) <= 3 then -- 30% chance
        StoryMode.TriggerRandomEvent(player)
    end
end

function StoryMode.CompleteObjective(player, objective)
    local progress = playerProgress[player.UserId]
    if progress then
        progress.objectives[objective] = true
        -- Check if all objectives done
        local chapter = storyChapters[progress.chapter]
        local allDone = true
        for _, obj in ipairs(chapter.objectives) do
            if not progress.objectives[obj] then allDone = false break end
        end
        if allDone then
            StoryMode.CompleteChapter(player)
        end
    end
end

function StoryMode.CompleteSideQuest(player, sideQuest)
    local progress = playerProgress[player.UserId]
    if progress then
        progress.sideQuests[sideQuest] = true
        -- Bonus exp pour quête secondaire
        _G.GainExp(player, 100)
    end
end

function StoryMode.TriggerRandomEvent(player)
    local events = {
        "Rencontre avec un marchand ambulant",
        "Attaque surprise d'ennemis",
        "Découverte d'un trésor caché",
        "Apparition d'un boss secret"
    }
    local event = events[math.random(#events)]
    StoryMode.ShowDialogue("Événement", event)
    -- Effets aléatoires
    if event == "Rencontre avec un marchand ambulant" then
        require(game.ReplicatedStorage.InventoryModule).AddItem(player, "Potion", 2)
    elseif event == "Attaque surprise d'ennemis" then
        -- Spawn ennemis temporaires
    elseif event == "Découverte d'un trésor caché" then
        _G.GainExp(player, 200)
    elseif event == "Apparition d'un boss secret" then
        local bosses = {"AncientGuardian", "ShadowDragon", "NecromancerKing", "CrystalBehemoth", "VoidSerpent"}
        local bossName = bosses[math.random(#bosses)]
        local position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-20,20), 0, math.random(-20,20))
        require(game.ReplicatedStorage.BossModule).CreateSecretBoss(bossName, position)
        StoryMode.ShowDialogue("Narrateur", "Un boss secret apparaît : " .. bossName .. " !")
    end
end

function StoryMode.CompleteChapter(player)
    local progress = playerProgress[player.UserId]
    if progress then
        local chapter = storyChapters[progress.chapter]
        _G.GainExp(player, chapter.reward.exp)
        require(game.ReplicatedStorage.InventoryModule).AddItem(player, chapter.reward.item, 1)
        playerProgress[player.UserId] = nil
        -- Next chapter cinematic
        if storyChapters[progress.chapter + 1] then
            wait(2)
            StoryMode.StartChapter(player, progress.chapter + 1)
        end
    end
end

function StoryMode.GetSideQuests(player)
    local progress = playerProgress[player.UserId]
    if progress then
        return storyChapters[progress.chapter].sideQuests or {}
    end
    return {}
end

function StoryMode.GetCurrentChapter(player)
    return playerProgress[player.UserId] and playerProgress[player.UserId].chapter or 0
end

return StoryMode
