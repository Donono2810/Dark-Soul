-- ModuleScript pour les armes (plus d'options)
local WeaponModule = {}

local weapons = {
    ["Sword"] = {damage = 20, speed = 1.5},
    ["Axe"] = {damage = 35, speed = 2.0},
    ["Dagger"] = {damage = 15, speed = 1.0},
    ["Greatsword"] = {damage = 50, speed = 2.5}, -- Très lente mais puissante
    ["Bow"] = {damage = 25, speed = 1.2, ranged = true} -- À distance (pas implémenté pleinement)
}

function WeaponModule.GetWeaponStats(weaponName)
    return weapons[weaponName] or {damage = 10, speed = 1.5}
end

return WeaponModule