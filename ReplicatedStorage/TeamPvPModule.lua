local TeamPvPModule = {}

-- Module pour événements PvP en équipe
TeamPvPModule.Events = {
    TeamBattle = {Teams = 2, PlayersPerTeam = 5}
}

-- Fonction pour rejoindre une équipe
function TeamPvPModule.JoinTeam(player, eventName, teamId)
    local event = TeamPvPModule.Events[eventName]
    if event then
        -- Ajouter à équipe
    end
end

return TeamPvPModule