local GuildTerritoriesModule = {}

-- Module pour guildes avec territoires
GuildTerritoriesModule.Territories = {} -- Zones contrôlées

-- Fonction pour revendiquer un territoire
function GuildTerritoriesModule.ClaimTerritory(guild, zone)
    GuildTerritoriesModule.Territories[zone] = guild
end

-- Fonction pour défendre
function GuildTerritoriesModule.DefendTerritory(guild, zone)
    -- Logique de défense
end

return GuildTerritoriesModule