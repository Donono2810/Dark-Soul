local HardModeModule = {}

-- Module pour mode difficile
HardModeModule.Settings = {
    EnemyDamage = 1.5,
    Checkpoints = false
}

-- Fonction pour activer mode difficile
function HardModeModule.EnableHardMode(player)
    player:SetAttribute("HardMode", true)
    -- Appliquer settings
end

return HardModeModule