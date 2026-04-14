local FatigueModule = {}

-- Module pour le système de fatigue
FatigueModule.FatigueLevels = {
    Low = 0,
    Medium = 50,
    High = 100
}

-- Fonction pour appliquer la fatigue
function FatigueModule.ApplyFatigue(player, amount)
    local currentFatigue = player:GetAttribute("Fatigue") or 0
    player:SetAttribute("Fatigue", math.min(currentFatigue + amount, 100))
    
    -- Réduire les stats selon la fatigue
    if player:GetAttribute("Fatigue") >= FatigueModule.FatigueLevels.High then
        -- Réduire vitesse, dégâts, etc.
    end
end

-- Fonction pour récupérer de la fatigue
function FatigueModule.RecoverFatigue(player, amount)
    local currentFatigue = player:GetAttribute("Fatigue") or 0
    player:SetAttribute("Fatigue", math.max(currentFatigue - amount, 0))
end

return FatigueModule