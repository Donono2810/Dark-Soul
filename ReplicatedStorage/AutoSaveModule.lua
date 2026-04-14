local AutoSaveModule = {}

-- Module pour la sauvegarde automatique
AutoSaveModule.SaveInterval = 300 -- 5 minutes

-- Fonction pour sauvegarder les données
function AutoSaveModule.AutoSave(player)
    -- Sauvegarder stats, inventaire, etc. via DataStore
    while true do
        wait(AutoSaveModule.SaveInterval)
        -- Code de sauvegarde
    end
end

return AutoSaveModule