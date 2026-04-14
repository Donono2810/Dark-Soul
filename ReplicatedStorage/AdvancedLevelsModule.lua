local AdvancedLevelsModule = {}

-- Module pour les niveaux avancés (au-delà de 100)
AdvancedLevelsModule.SoulLevels = {
    [101] = {Bonus = "+5 Dmg"},
    [200] = {Bonus = "+10 HP"}
}

-- Fonction pour monter de niveau d'âme
function AdvancedLevelsModule.LevelUpSoul(player)
    local currentLevel = player:GetAttribute("SoulLevel") or 100
    player:SetAttribute("SoulLevel", currentLevel + 1)
    -- Appliquer bonus
end

return AdvancedLevelsModule