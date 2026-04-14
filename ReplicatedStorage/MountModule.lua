local MountModule = {}

-- Module pour gérer les montures dans le jeu
-- Les montures permettent aux joueurs de voyager plus rapidement sur de longues distances

local mountTypes = {
    ["Horse"] = {
        speed = 25,
        health = 100,
        description = "Cheval robuste pour les voyages terrestres.",
        price = 400
    },
    ["Unicorn"] = {
        speed = 30,
        health = 120,
        description = "Licorne magique avec une vitesse accrue.",
        price = 600
    },
    ["WolfMount"] = {
        speed = 35,
        health = 80,
        description = "Loup géant rapide et agile.",
        price = 500
    },
    ["Dragon"] = {
        speed = 50,
        health = 200,
        description = "Dragon volant pour des voyages aériens.",
        price = 1200
    },
    ["Griffin"] = {
        speed = 45,
        health = 150,
        description = "Griffon ailé pour la vitesse et l'agilité.",
        price = 1000
    },
    ["Elephant"] = {
        speed = 20,
        health = 300,
        description = "Éléphant lent mais très résistant.",
        price = 800
    },
    ["Pegasus"] = {
        speed = 55,
        health = 180,
        description = "Pégase volant légendaire.",
        price = 1500
    },
    ["Rhinoceros"] = {
        speed = 15,
        health = 250,
        description = "Rhinocéros chargeur puissant.",
        price = 700
    },
    ["Camel"] = {
        speed = 22,
        health = 110,
        description = "Chameau endurant pour les déserts.",
        price = 350
    },
    ["Tiger"] = {
        speed = 40,
        health = 90,
        description = "Tigre rapide et féroce.",
        price = 650
    }
}

-- Fonction pour obtenir la liste des types de montures
function MountModule.GetMountTypes()
    return mountTypes
end

-- Fonction pour donner une monture à un joueur
function MountModule.GiveMount(player, mountName)
    local mount = mountTypes[mountName]
    if not mount then return false end

    -- Créer la monture dans le monde
    local mountModel = Instance.new("Model")
    mountModel.Name = mountName .. "Mount"
    mountModel.Parent = workspace

    -- Partie principale
    local rootPart = Instance.new("Part")
    rootPart.Name = "HumanoidRootPart"
    rootPart.Size = Vector3.new(4, 2, 8)
    rootPart.Anchored = false
    rootPart.CanCollide = true
    rootPart.Position = player.Character.HumanoidRootPart.Position + Vector3.new(10, 0, 0)
    rootPart.BrickColor = BrickColor.new("Brown")
    rootPart.Parent = mountModel

    -- Si c'est un dragon ou pégase, ajouter des ailes ou vol
    if mountName == "Dragon" or mountName == "Pegasus" or mountName == "Griffin" then
        -- Ajouter une capacité de vol simple
        local flyScript = Instance.new("Script")
        flyScript.Source = [[
            local mount = script.Parent
            local root = mount:WaitForChild("HumanoidRootPart")
            while true do
                wait(0.1)
                if root:FindFirstChild("Seat") and root.Seat.Occupant then
                    root.Anchored = true
                    root.Position = root.Position + Vector3.new(0, 0.5, 0) -- Simuler vol
                else
                    root.Anchored = false
                end
            end
        ]]
        flyScript.Parent = mountModel
    end

    -- Si terrestre, ajouter mouvement
    local moveScript = Instance.new("Script")
    moveScript.Source = [[
        local mount = script.Parent
        local root = mount:WaitForChild("HumanoidRootPart")
        local speed = ]] .. mount.speed .. [[
        while true do
            wait(0.1)
            if root:FindFirstChild("Seat") and root.Seat.Occupant then
                local direction = root.Seat.Occupant.Parent.HumanoidRootPart.CFrame.LookVector
                root.Velocity = direction * speed
            end
        end
    ]]
    moveScript.Parent = mountModel

    -- Siège pour monter
    local seat = Instance.new("VehicleSeat")
    seat.Name = "Seat"
    seat.Size = Vector3.new(2, 1, 2)
    seat.Position = rootPart.Position + Vector3.new(0, 1, 0)
    seat.Anchored = false
    seat.Parent = rootPart

    -- Weld le siège à la root
    local weld = Instance.new("Weld")
    weld.Part0 = rootPart
    weld.Part1 = seat
    weld.C0 = CFrame.new(0, 1, 0)
    weld.Parent = seat

    -- Stocker la monture dans les données du joueur
    local playerData = player:FindFirstChild("PlayerData")
    if playerData then
        local mountsFolder = playerData:FindFirstChild("Mounts") or Instance.new("Folder")
        mountsFolder.Name = "Mounts"
        mountsFolder.Parent = playerData

        local mountValue = Instance.new("StringValue")
        mountValue.Name = mountName
        mountValue.Value = mountModel.Name
        mountValue.Parent = mountsFolder
    end

    return true
end

return MountModule