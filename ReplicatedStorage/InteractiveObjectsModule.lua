local InteractiveObjectsModule = {}

-- Module pour objets interactifs
InteractiveObjectsModule.Objects = {
    Lever = {Action = "OpenDoor"},
    Chest = {Action = "GiveLoot"}
}

-- Fonction pour interagir
function InteractiveObjectsModule.Interact(player, objectName)
    local obj = InteractiveObjectsModule.Objects[objectName]
    if obj then
        -- Exécuter action
    end
end

return InteractiveObjectsModule