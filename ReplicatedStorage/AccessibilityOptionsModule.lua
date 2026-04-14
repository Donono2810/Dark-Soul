local AccessibilityOptionsModule = {}

-- Module pour options d'accessibilité
AccessibilityOptionsModule.Options = {
    ColorBlind = true,
    LargeText = true,
    AltControls = true
}

-- Fonction pour appliquer option
function AccessibilityOptionsModule.ApplyOption(player, option)
    player:SetAttribute(option, true)
    -- Ajuster jeu
end

return AccessibilityOptionsModule