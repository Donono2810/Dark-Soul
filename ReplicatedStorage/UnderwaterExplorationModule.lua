local UnderwaterExplorationModule = {}

-- Module pour exploration sous-marine
UnderwaterExplorationModule.Zones = {
    OceanDepths = {OxygenTime = 60, Enemies = {"Fish", "Kraken"}}
}

-- Fonction pour entrer en zone sous-marine
function UnderwaterExplorationModule.EnterUnderwater(player, zoneName)
    local zone = UnderwaterExplorationModule.Zones[zoneName]
    if zone then
        -- Démarrer timer oxygène
        player:SetAttribute("Oxygen", zone.OxygenTime)
    end
end

return UnderwaterExplorationModule