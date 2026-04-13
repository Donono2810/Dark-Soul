-- LocalScript pour gérer l'inventaire du joueur (utiliser des items)
local InventoryModule = require(game.ReplicatedStorage.InventoryModule)
local player = game.Players.LocalPlayer

-- Exemple : ajouter des potions au départ
InventoryModule.AddItem(player, "Potion", 3)

-- Touche E pour utiliser une potion
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then
        if InventoryModule.UseItem(player, "Potion") then
            print("Potion utilisée ! Santé restaurée.")
        else
            print("Pas de potion disponible.")
        end
    end
end)

-- Afficher inventaire (simple print pour test)
wait(5)
local inv = InventoryModule.GetInventory(player)
print("Inventaire :", inv)