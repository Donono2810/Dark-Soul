local ReferralSystemModule = {}

-- Module pour système de parrainage
ReferralSystemModule.Referrals = {} -- Suivi des parrainages

-- Fonction pour parrainer
function ReferralSystemModule.ReferPlayer(sponsor, newPlayer)
    ReferralSystemModule.Referrals[newPlayer] = sponsor
    -- Récompenses
end

return ReferralSystemModule