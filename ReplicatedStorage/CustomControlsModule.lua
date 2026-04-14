local CustomControlsModule = {}

-- Module pour les contrôles personnalisables
CustomControlsModule.DefaultControls = {
    Dodge = "Q",
    CastSpell = "E"
}

-- Fonction pour changer un contrôle
function CustomControlsModule.ChangeControl(player, action, key)
    player:SetAttribute(action .. "Key", key)
end

return CustomControlsModule