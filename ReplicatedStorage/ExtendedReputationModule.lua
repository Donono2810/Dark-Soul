local ExtendedReputationModule = {}

-- Module pour étendre le système de réputation
ExtendedReputationModule.Factions = {
    Alliance = {Bonus = "+10% Dmg vs Enemies"},
    Horde = {Bonus = "+5 HP Regen"}
}

-- Fonction pour changer de faction
function ExtendedReputationModule.ChangeFaction(player, factionName)
    player:SetAttribute("Faction", factionName)
    -- Appliquer bonus
end

return ExtendedReputationModule