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

            -- Cinématique d'introduction
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = CFrame.new(Vector3.new(0, 10, -20), Vector3.new(0, 0, 0))

            -- Tween vers le personnage
            local tweenInfo = TweenInfo.new(5, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(camera, tweenInfo, {CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 5, -10)})
            tween:Play()
            tween.Completed:Wait()

            -- Dialogue
            StoryMode.ShowDialogue("Narrateur", "Bienvenue dans les Terres Maudites. Votre quête commence ici.")
            wait(3)
            StoryMode.ShowDialogue("Narrateur", "Affrontez les ennemis et progressez dans les zones.")
            wait(3)

            camera.CameraType = Enum.CameraType.Custom
        end,
        objectives = {"Tuer 5 ennemis", "Explorer Zone 1"},
        reward = {exp = 200, item = "Sword"}
    },
    [2] = {
        title = "Le Premier Boss",
        cinematic = function(player)
            -- Cinématique avant boss
            StoryMode.ShowDialogue("Ancien", "Le boss vous attend. Préparez-vous !")
            wait(2)
        end,
        objectives = {"Tuer le Boss Zone 1"},
        reward = {exp = 500, item = "Greatsword"}
    }
}

local playerProgress = {}

function StoryMode.StartChapter(player, chapterId)
    local chapter = storyChapters[chapterId]
    if not chapter then return end

    playerProgress[player.UserId] = {chapter = chapterId, objectives = {}}

    -- Jouer la cinématique
    chapter.cinematic(player)

    -- Téléporter à la zone
    local zone = workspace:FindFirstChild("Zone" .. chapterId)
    if zone and zone:FindFirstChild("Spawn") then
        player.Character.HumanoidRootPart.CFrame = zone.Spawn.CFrame
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

function StoryMode.ShowDialogue(speaker, text)
    -- Créer une GUI de dialogue
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.8, 0, 0.2, 0)
    frame.Position = UDim2.new(0.1, 0, 0.8, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.Parent = screenGui

    local speakerLabel = Instance.new("TextLabel")
    speakerLabel.Size = UDim2.new(1, 0, 0.3, 0)
    speakerLabel.Text = speaker
    speakerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    speakerLabel.Parent = frame

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.7, 0)
    textLabel.Position = UDim2.new(0, 0, 0.3, 0)
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextWrapped = true
    textLabel.Parent = frame

    wait(5) -- Durée du dialogue
    screenGui:Destroy()
end

return StoryMode
