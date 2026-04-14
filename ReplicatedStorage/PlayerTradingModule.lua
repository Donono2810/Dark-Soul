local PlayerTradingModule = {}

-- Module pour l'échange entre joueurs
PlayerTradingModule.Trades = {}

-- Fonction pour initier un échange
function PlayerTradingModule.StartTrade(player1, player2)
    PlayerTradingModule.Trades[player1.UserId .. player2.UserId] = {Player1 = player1, Player2 = player2}
end

-- Fonction pour confirmer l'échange
function PlayerTradingModule.ConfirmTrade(tradeId)
    -- Échanger items
end

return PlayerTradingModule