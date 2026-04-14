local EnvironmentalSoundsModule = {}

-- Module pour effets sonores environnementaux
EnvironmentalSoundsModule.Sounds = {
    Rain = "rbxassetid://123456",
    Night = "rbxassetid://654321"
}

-- Fonction pour jouer un son
function EnvironmentalSoundsModule.PlaySound(context)
    local sound = Instance.new("Sound", workspace)
    sound.SoundId = EnvironmentalSoundsModule.Sounds[context]
    sound:Play()
end

return EnvironmentalSoundsModule