local CosmeticModule = {}

-- Module pour les objets cosmétiques
CosmeticModule.Items = {
    FireTrail = {Type = "Trail", Effect = "Particles"},
    GoldenSwordSkin = {Type = "WeaponSkin", Color = "Gold"}
}

-- Fonction pour appliquer un cosmétique
function CosmeticModule.ApplyCosmetic(player, itemName)
    local item = CosmeticModule.Items[itemName]
    if item then
        -- Appliquer effet visuel
        if item.Type == "Trail" then
            -- Ajouter particules
        end
    end
end

return CosmeticModule