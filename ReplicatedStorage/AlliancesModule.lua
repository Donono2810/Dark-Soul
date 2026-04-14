local AlliancesModule = {}

-- Module pour alliances
AlliancesModule.Alliances = {} -- Groupes d'alliances

-- Fonction pour former une alliance
function AlliancesModule.FormAlliance(guild1, guild2)
    table.insert(AlliancesModule.Alliances, {guild1, guild2})
end

-- Fonction pour objectifs communs
function AlliancesModule.SharedObjectives(alliance)
    -- Définir objectifs
end

return AlliancesModule