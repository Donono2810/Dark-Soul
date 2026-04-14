local ParryCounterModule = {}

-- Module pour parade et contre-attaque
ParryCounterModule.ParryWindow = 0.5 -- secondes

-- Fonction pour activer la parade
function ParryCounterModule.Parry(player)
    player:SetAttribute("Parrying", true)
    wait(ParryCounterModule.ParryWindow)
    player:SetAttribute("Parrying", false)
end

-- Fonction pour contre-attaque si parade réussie
function ParryCounterModule.CounterAttack(player, target)
    if player:GetAttribute("Parrying") then
        -- Appliquer dégâts bonus
        target.Humanoid:TakeDamage(50)
    end
end

return ParryCounterModule