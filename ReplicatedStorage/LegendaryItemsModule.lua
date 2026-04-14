local LegendaryItemsModule = {}

-- Module pour les armes et armures légendaires
LegendaryItemsModule.Items = {
    Excalibur = {Type = "Weapon", Damage = 100, Effect = "HolyDamage"},
    DragonArmor = {Type = "Armor", Defense = 50, Effect = "FireResistance"}
}

-- Fonction pour équiper un item légendaire
function LegendaryItemsModule.EquipItem(player, itemName)
    local item = LegendaryItemsModule.Items[itemName]
    if item then
        -- Appliquer stats et effets
        player:SetAttribute(item.Type .. "Bonus", item.Damage or item.Defense)
    end
end

return LegendaryItemsModule