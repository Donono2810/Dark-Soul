-- ModuleScript pour gérer les buffs et debuffs
local BuffModule = {}

local activeBuffs = {}

function BuffModule.ApplyBuff(player, buffType, duration)
    if not activeBuffs[player] then activeBuffs[player] = {} end
    activeBuffs[player][buffType] = tick() + duration
end

function BuffModule.HasBuff(player, buffType)
    if not activeBuffs[player] then return false end
    return activeBuffs[player][buffType] and tick() < activeBuffs[player][buffType]
end

function BuffModule.Update(player)
    if not activeBuffs[player] then return end
    for buff, endTime in pairs(activeBuffs[player]) do
        if tick() > endTime then
            activeBuffs[player][buff] = nil
        end
    end
end

-- Exemple : poison debuff
function BuffModule.ApplyPoison(player, character)
    BuffModule.ApplyBuff(player, "poison", 10)
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        for i = 1, 10 do
            wait(1)
            if BuffModule.HasBuff(player, "poison") then
                humanoid:TakeDamage(5)
            else
                break
            end
        end
    end
end

return BuffModule