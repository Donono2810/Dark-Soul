-- ModuleScript pour les compagnons (pets)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local PetModule = {}
local playerPets = {}
local petTypes = {
    ["Wolf"] = {damage = 10, health = 50, ability = "Attack"},
    ["Raven"] = {damage = 5, health = 30, ability = "Scout"},
    ["Golem"] = {damage = 20, health = 100, ability = "Tank"}
}

local petStore = DataStoreService:GetDataStore("DarkSoulPets")

function PetModule.GetPetTypes()
    return petTypes
end

function PetModule.GetPlayerPet(player)
    return playerPets[player.UserId]
end

function PetModule.SummonPet(player, petName)
    if not petTypes[petName] or playerPets[player.UserId] then return false end
    local petData = petTypes[petName]
    -- Create pet model in workspace
    local petModel = Instance.new("Model")
    petModel.Name = petName .. "Pet"
    -- Add parts, humanoid, etc.
    petModel.Parent = workspace
    playerPets[player.UserId] = {name = petName, model = petModel, data = petData}
    return true
end

function PetModule.DismissPet(player)
    if playerPets[player.UserId] then
        playerPets[player.UserId].model:Destroy()
        playerPets[player.UserId] = nil
    end
end

function PetModule.LoadPlayer(player)
    local success, data = pcall(function()
        return petStore:GetAsync("PET_" .. player.UserId)
    end)
    if success and type(data) == "table" then
        playerPets[player.UserId] = data
    end
end

function PetModule.SavePlayer(player)
    local data = playerPets[player.UserId]
    if data then
        pcall(function()
            petStore:SetAsync("PET_" .. player.UserId, data)
        end)
    end
end

return PetModule
