local RandomTeleportersModule = {}

-- Module pour téléporteurs aléatoires
RandomTeleportersModule.Destinations = {"Zone1", "Zone2", "SecretZone"}

-- Fonction pour téléporter aléatoirement
function RandomTeleportersModule.RandomTeleport(player)
    local dest = RandomTeleportersModule.Destinations[math.random(#RandomTeleportersModule.Destinations)]
    -- Téléporter à dest
end

return RandomTeleportersModule