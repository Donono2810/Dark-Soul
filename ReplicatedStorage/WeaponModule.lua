-- ModuleScript pour les armes (stats différentes)
local WeaponModule = {}

local weapons = {
    ["Sword"] = {damage = 20, speed = 1.5},
    ["Axe"] = {damage = 35, speed = 2.0}, -- Plus lent mais plus fort
    ["Dagger"] = {damage = 15, speed = 1.0} -- Rapide mais faible
}

function WeaponModule.GetWeaponStats(weaponName)
    return weapons[weaponName] or {damage = 10, speed = 1.5}
end

return WeaponModule