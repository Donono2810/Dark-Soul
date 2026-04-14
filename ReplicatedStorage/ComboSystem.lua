local ComboSystem = {}

-- Module pour le système de combos
ComboSystem.Combos = {
    Basic = {Sequence = {"Attack1", "Attack2"}, Bonus = 1.5},
    Advanced = {Sequence = {"Attack1", "Attack2", "Attack3"}, Bonus = 2.0}
}

-- Fonction pour vérifier et appliquer un combo
function ComboSystem.CheckCombo(player, attackSequence)
    for name, combo in pairs(ComboSystem.Combos) do
        if #attackSequence == #combo.Sequence then
            local match = true
            for i, seq in ipairs(combo.Sequence) do
                if attackSequence[i] ~= seq then
                    match = false
                    break
                end
            end
            if match then
                return combo.Bonus
            end
        end
    end
    return 1.0 -- Pas de bonus
end

return ComboSystem