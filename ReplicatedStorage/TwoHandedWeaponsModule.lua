local TwoHandedWeaponsModule = {}

-- Module pour armes à deux mains
TwoHandedWeaponsModule.Weapons = {
    GreatAxe = {Damage = 80, Speed = 2.5, StaminaCost = 30}
}

-- Fonction pour équiper une arme à deux mains
function TwoHandedWeaponsModule.EquipTwoHanded(player, weaponName)
    local weapon = TwoHandedWeaponsModule.Weapons[weaponName]
    if weapon then
        player:SetAttribute("TwoHandedEquipped", true)
        -- Ajuster stats
    end
end

return TwoHandedWeaponsModule