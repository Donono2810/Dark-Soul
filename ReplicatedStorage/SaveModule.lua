-- ModuleScript pour la sauvegarde (niveau, exp, inventaire)
local SaveModule = {}

local playerData = {} -- Stockage temporaire (en prod, utiliser DataStore)

function SaveModule.SaveData(player)
    playerData[player.UserId] = {
        level = _G.playerLevels[player.UserId] or 1,
        exp = _G.playerExp[player.UserId] or 0,
        inventory = require(game.ReplicatedStorage.InventoryModule).GetInventory(player),
        equipment = require(game.ReplicatedStorage.InventoryModule).GetEquipment(player)
    }
end

function SaveModule.LoadData(player)
    local data = playerData[player.UserId]
    if data then
        _G.playerLevels[player.UserId] = data.level
        _G.playerExp[player.UserId] = data.exp
        -- Restaurer inventaire/équipement (simplifié)
        for item, qty in pairs(data.inventory) do
            require(game.ReplicatedStorage.InventoryModule).AddItem(player, item, qty)
        end
        if data.equipment.weapon then
            require(game.ReplicatedStorage.InventoryModule).EquipItem(player, data.equipment.weapon)
        end
    end
end

-- Sauvegarder automatiquement
game.Players.PlayerRemoving:Connect(function(player)
    SaveModule.SaveData(player)
end)

return SaveModule