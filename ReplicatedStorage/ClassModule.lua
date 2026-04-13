-- ModuleScript pour le système de classe
local ClassModule = {}

local classes = {
    ["Warrior"] = {
        health = 150,
        mana = 50,
        damageBonus = 15,
        speed = 12,
        description = "Force brute, haute santé",
        startItems = {["Sword"] = 1, ["Potion"] = 5},
        specialAbility = "Charge brutale"
    },
    ["Mage"] = {
        health = 80,
        mana = 200,
        damageBonus = 10,
        speed = 10,
        description = "Magie puissante, low HP",
        startItems = {["Dagger"] = 1, ["Fireball"] = 10, ["Potion"] = 3},
        specialAbility = "Tempête de feu"
    },
    ["Archer"] = {
        health = 100,
        mana = 100,
        damageBonus = 12,
        speed = 15,
        description = "Rapide et précis",
        startItems = {["Bow"] = 1, ["Dagger"] = 1, ["Potion"] = 4},
        specialAbility = "Salve de flèches"
    },
    ["Rogue"] = {
        health = 90,
        mana = 75,
        damageBonus = 20,
        speed = 18,
        description = "Ultra-rapide, moyen HP",
        startItems = {["Dagger"] = 2, ["Rapier"] = 1, ["Potion"] = 3},
        specialAbility = "Coup fatal"
    },
    ["Paladin"] = {
        health = 140,
        mana = 120,
        damageBonus = 18,
        speed = 11,
        description = "Équilibré, polyvalent",
        startItems = {["Sword"] = 1, ["ShieldSpell"] = 5, ["HealSpell"] = 5, ["Potion"] = 4},
        specialAbility = "Aura protectrice"
    }
}

local playerClasses = {} -- Stocke la classe par joueur

function ClassModule.GetClasses()
    return classes
end

function ClassModule.SetPlayerClass(player, className)
    if classes[className] then
        playerClasses[player.UserId] = className
        return true
    end
    return false
end

function ClassModule.GetPlayerClass(player)
    return playerClasses[player.UserId] or "Warrior" -- Défaut: Warrior
end

function ClassModule.GetClassStats(className)
    return classes[className] or classes["Warrior"]
end

function ClassModule.ApplyClassBonus(player, baseHealth)
    local className = ClassModule.GetPlayerClass(player)
    local stats = classes[className]
    return baseHealth + stats.damageBonus
end

return ClassModule