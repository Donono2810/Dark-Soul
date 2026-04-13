-- ModuleScript pour les armes (plus d'options)
local WeaponModule = {}

local weapons = {
    ["Sword"] = {damage = 20, speed = 1.5},
    ["Axe"] = {damage = 35, speed = 2.0},
    ["Dagger"] = {damage = 15, speed = 1.0},
    ["Greatsword"] = {damage = 50, speed = 2.5}, -- Très lente mais puissante
    ["Bow"] = {damage = 25, speed = 1.2, ranged = true},
    ["Katana"] = {damage = 45, speed = 1.3}, -- Rapide et forte
    ["Hammer"] = {damage = 60, speed = 3.0}, -- Très lente, très puissante
    ["Spear"] = {damage = 30, speed = 1.4}, -- Équilibrée avec allonge
    ["Scythe"] = {damage = 55, speed = 2.3}, -- Spéciale, puissante
    ["Rapier"] = {damage = 18, speed = 0.8} -- Très rapide mais faible
}

function WeaponModule.GetWeaponStats(weaponName)
    return weapons[weaponName] or {damage = 10, speed = 1.5}
end

return WeaponModule