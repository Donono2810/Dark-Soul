local SeasonalChangesModule = {}

-- Module pour système de saison
SeasonalChangesModule.Seasons = {
    Autumn = {Leaves = true},
    Winter = {Snow = true}
}

-- Fonction pour changer de saison
function SeasonalChangesModule.SetSeason(seasonName)
    local season = SeasonalChangesModule.Seasons[seasonName]
    if season then
        -- Appliquer effets visuels
    end
end

return SeasonalChangesModule