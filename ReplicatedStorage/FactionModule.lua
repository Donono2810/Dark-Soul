local FactionModule = {}

-- Module pour le système de factions
-- Les joueurs peuvent rejoindre des factions pour des buffs et compétitions

local factions = {
    ["Knights"] = {description = "Guerriers honorables, bonus de défense.", buff = {defense = 10}},
    ["Mages"] = {description = "Maîtres de la magie, bonus de mana.", buff = {mana = 20}},
    ["Rogues"] = {description = "Voleurs agiles, bonus de vitesse.", buff = {speed = 5}},
    ["Druids"] = {description = "Gardiens de la nature, bonus de régénération.", buff = {regen = 2}}
}

-- Fonction pour rejoindre une faction
function FactionModule.JoinFaction(player, factionName)
    local faction = factions[factionName]
    if not faction then
        return false, "Faction inconnue."
    end

    local playerData = player:FindFirstChild("PlayerData")
    if not playerData then
        return false, "Données joueur introuvables."
    end

    local factionValue = playerData:FindFirstChild("Faction") or Instance.new("StringValue")
    factionValue.Name = "Faction"
    factionValue.Value = factionName
    factionValue.Parent = playerData

    -- Appliquer le buff
    for buffType, value in pairs(faction.buff) do
        if buffType == "defense" then
            player.Character.Humanoid.Health = player.Character.Humanoid.Health + value
        elseif buffType == "mana" then
            -- Assumer mana stocké quelque part
        elseif buffType == "speed" then
            player.Character.Humanoid.WalkSpeed = player.Character.Humanoid.WalkSpeed + value
        elseif buffType == "regen" then
            -- Régénération périodique
        end
    end

    local notification = Instance.new("Hint")
    notification.Text = "Rejoint la faction : " .. factionName .. " - " .. faction.description
    notification.Parent = player.PlayerGui
    wait(3)
    notification:Destroy()

    return true, "Faction rejointe !"
end

-- Fonction pour obtenir les factions
function FactionModule.GetFactions()
    return factions
end

return FactionModule