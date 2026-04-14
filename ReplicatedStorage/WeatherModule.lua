local WeatherModule = {}

-- Module pour les effets météorologiques
WeatherModule.Effects = {
    Rain = {Visibility = 0.8, Speed = -2},
    Fog = {Visibility = 0.5}
}

-- Fonction pour appliquer la météo
function WeatherModule.ApplyWeather(weatherName)
    local effect = WeatherModule.Effects[weatherName]
    if effect then
        -- Ajuster visibilité, vitesse, etc.
        game.Lighting.FogEnd = effect.Visibility * 1000
    end
end

return WeatherModule