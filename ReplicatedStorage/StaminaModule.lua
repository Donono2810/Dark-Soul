-- ModuleScript pour gérer la stamina
local StaminaModule = {}

local playerStamina = {}

function StaminaModule.Init(player)
    playerStamina[player] = {
        current = 100,
        max = 100,
        regenRate = 10,
        lastUse = 0
    }
end

function StaminaModule.UseStamina(player, amount)
    local data = playerStamina[player]
    if not data then return false end
    if data.current >= amount then
        data.current = data.current - amount
        data.lastUse = tick()
        return true
    end
    return false
end

function StaminaModule.GetStamina(player)
    local data = playerStamina[player]
    return data and data.current or 0
end

function StaminaModule.Update(player)
    local data = playerStamina[player]
    if not data then return end
    if tick() - data.lastUse > 1 then
        data.current = math.min(data.max, data.current + data.regenRate * 0.1)
    end
end

function StaminaModule.RestoreStamina(player, amount)
    local data = playerStamina[player]
    if not data then return end
    data.current = math.min(data.max, data.current + amount)
end

return StaminaModule