local SeasonalEventsModule = {}

-- Module pour les événements saisonniers
SeasonalEventsModule.Events = {
    Halloween = {Monsters = {"Pumpkin", "Ghost"}, Rewards = {"Candy", "ScaryMask"}},
    Christmas = {Monsters = {"Snowman", "Elf"}, Rewards = {"Gift", "Snowball"}}
}

-- Fonction pour activer un événement
function SeasonalEventsModule.ActivateEvent(eventName)
    local event = SeasonalEventsModule.Events[eventName]
    if event then
        -- Générer monstres et récompenses
    end
end

return SeasonalEventsModule