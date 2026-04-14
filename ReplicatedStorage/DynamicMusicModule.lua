local DynamicMusicModule = {}

-- Module pour la musique dynamique
DynamicMusicModule.Tracks = {
    Combat = "rbxassetid://123456789",
    Exploration = "rbxassetid://987654321"
}

-- Fonction pour changer la musique
function DynamicMusicModule.ChangeMusic(context)
    local sound = workspace:FindFirstChild("BackgroundMusic") or Instance.new("Sound", workspace)
    sound.SoundId = DynamicMusicModule.Tracks[context]
    sound:Play()
end

return DynamicMusicModule