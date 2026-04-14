-- ModuleScript pour les compagnons (pets)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local PetModule = {}
local playerPets = {}
local petTypes = {
    ["Wolf"] = {damage = 10, health = 50, ability = "Attack", description = "Loup fidèle qui attaque les ennemis.", price = 300},
    ["Raven"] = {damage = 5, health = 30, ability = "Scout", description = "Corbeau qui éclaire les zones.", price = 200},
    ["Golem"] = {damage = 20, health = 100, ability = "Tank", description = "Golem robuste qui absorbe les dégâts.", price = 500},
    ["Eagle"] = {damage = 15, health = 40, ability = "Dive", description = "Aigle qui plonge sur les ennemis.", price = 350},
    ["Bear"] = {damage = 25, health = 80, ability = "Roar", description = "Ours puissant qui intimide.", price = 600},
    ["Dragonling"] = {damage = 30, health = 60, ability = "FireBreath", description = "Petit dragon crachant du feu.", price = 800},
    ["Phoenix"] = {damage = 50, health = 120, ability = "Resurrect", description = "Phénix légendaire qui ressuscite.", price = 1500},
    ["ShadowCat"] = {damage = 12, health = 35, ability = "Stealth", description = "Chat de l'ombre furtif.", price = 400},
    ["IceFox"] = {damage = 18, health = 45, ability = "Freeze", description = "Renard de glace qui gèle.", price = 450},
    ["ThunderBird"] = {damage = 22, health = 55, ability = "Shock", description = "Oiseau du tonnerre électrifiant.", price = 700}
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
