local ChargedAttacksModule = {}

-- Module pour attaques chargées
ChargedAttacksModule.ChargeTime = 2 -- secondes

-- Fonction pour charger une attaque
function ChargedAttacksModule.ChargeAttack(player)
    local startTime = tick()
    -- Attendre la charge
    wait(ChargedAttacksModule.ChargeTime)
    local chargeLevel = (tick() - startTime) / ChargedAttacksModule.ChargeTime
    return math.min(chargeLevel, 1) * 2 -- Bonus jusqu'à 2x
end

return ChargedAttacksModule