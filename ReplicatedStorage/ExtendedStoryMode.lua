local ExtendedStoryMode = {}

-- Module pour mode histoire étendu
ExtendedStoryMode.Branches = {
    GoodEnding = {Choices = {"HelpVillagers"}, Reward = "HeroTitle"},
    BadEnding = {Choices = {"Betray"}, Reward = "DarkTitle"}
}

-- Fonction pour choix narratif
function ExtendedStoryMode.MakeChoice(player, choice)
    -- Impact sur l'histoire
end

return ExtendedStoryMode