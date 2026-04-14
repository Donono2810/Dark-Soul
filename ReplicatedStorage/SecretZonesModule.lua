local SecretZonesModule = {}

-- Module pour zones secrètes
SecretZonesModule.Zones = {
    HiddenCave = {Requirement = "SolvePuzzle", Reward = "Treasure"}
}

-- Fonction pour accéder à une zone
function SecretZonesModule.AccessZone(player, zoneName)
    local zone = SecretZonesModule.Zones[zoneName]
    if zone then
        -- Vérifier condition
        -- Téléporter joueur
    end
end

return SecretZonesModule