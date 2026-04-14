local PvPTournamentsModule = {}

-- Module pour les tournois PvP
PvPTournamentsModule.Tournaments = {
    Weekly = {Participants = {}, Prize = "LegendaryWeapon"}
}

-- Fonction pour s'inscrire
function PvPTournamentsModule.Register(player)
    table.insert(PvPTournamentsModule.Tournaments.Weekly.Participants, player)
end

-- Fonction pour déterminer le gagnant
function PvPTournamentsModule.EndTournament()
    -- Classer et distribuer prix
end

return PvPTournamentsModule