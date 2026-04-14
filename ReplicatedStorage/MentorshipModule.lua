local MentorshipModule = {}

-- Module pour le système de mentorat
MentorshipModule.Mentors = {}

-- Fonction pour devenir mentor
function MentorshipModule.BecomeMentor(player)
    MentorshipModule.Mentors[player.UserId] = true
end

-- Fonction pour guider un novice
function MentorshipModule.GuidePlayer(mentor, novice)
    -- Afficher tutoriel ou conseils
end

return MentorshipModule