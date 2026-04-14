local SpectatorModule = {}

-- Module pour le mode spectateur
SpectatorModule.Spectators = {}

-- Fonction pour entrer en mode spectateur
function SpectatorModule.EnterSpectator(player, targetPlayer)
    if targetPlayer and targetPlayer.Character then
        player:SetAttribute("Spectating", true)
        -- Attacher la caméra au joueur cible
        local camera = workspace.CurrentCamera
        camera.CameraSubject = targetPlayer.Character.Humanoid
    end
end

-- Fonction pour quitter le mode spectateur
function SpectatorModule.ExitSpectator(player)
    player:SetAttribute("Spectating", false)
    local camera = workspace.CurrentCamera
    camera.CameraSubject = player.Character.Humanoid
end

return SpectatorModule