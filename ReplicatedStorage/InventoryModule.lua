-- ModuleScript pour un système d'inventaire étendu (armes, potions, équipements)
local InventoryModule = {}

local playerInventories = {} -- Stockage par joueur
local playerEquipment = {} -- Équipement actuel (arme, armure)

function InventoryModule.AddItem(player, itemName, quantity)
    if not playerInventories[player.UserId] then
        playerInventories[player.UserId] = {}
    end
    playerInventories[player.UserId][itemName] = (playerInventories[player.UserId][itemName] or 0) + quantity
end

function InventoryModule.UseItem(player, itemName)
    if playerInventories[player.UserId] and playerInventories[player.UserId][itemName] and playerInventories[player.UserId][itemName] > 0 then
        playerInventories[player.UserId][itemName] = playerInventories[player.UserId][itemName] - 1
        -- Effets
        if itemName == "Potion" then
            local char = player.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.Health = math.min(char.Humanoid.Health + 30, char.Humanoid.MaxHealth)
            end
        elseif itemName == "Fireball" then
            -- Utilisé dans le script de magie
            return "spell"
        end
        return true
    end
    return false
end

local playerEquipment = {} -- Équipement actuel (arme, armure: helmet, chest, legs, shield)

function InventoryModule.EquipItem(player, itemName, slot)
    if playerInventories[player.UserId] and playerInventories[player.UserId][itemName] then
        playerEquipment[player.UserId] = playerEquipment[player.UserId] or {}
        if slot then
            playerEquipment[player.UserId][slot] = itemName
        else
            playerEquipment[player.UserId].weapon = itemName
        end
        return true
    end
    return false
end

function InventoryModule.GetEquipment(player)
    return playerEquipment[player.UserId] or {}
end

function InventoryModule.GetTotalDefense(player)
    local equip = playerEquipment[player.UserId] or {}
    local defense = 0
    local armorStats = {
        ["LeatherHelmet"] = 5,
        ["LeatherChest"] = 10,
        ["LeatherLegs"] = 8,
        ["WoodenShield"] = 15,
        ["IronHelmet"] = 10,
        ["IronChest"] = 20,
        ["IronLegs"] = 15,
        ["IronShield"] = 25
    }
    for slot, item in pairs(equip) do
        if slot ~= "weapon" and armorStats[item] then
            defense = defense + armorStats[item]
        end
    end
    return defense
end

function InventoryModule.GetEquipment(player)
    return playerEquipment[player.UserId] or {}
end

return InventoryModule