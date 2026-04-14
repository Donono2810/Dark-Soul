local PhotoModeModule = {}

-- Module pour le mode photo
PhotoModeModule.Filters = {
    Sepia = "ColorCorrection",
    BlackWhite = "ColorCorrection"
}

-- Fonction pour activer le mode photo
function PhotoModeModule.EnterPhotoMode(player)
    -- Geler le jeu, ajuster caméra
    local camera = workspace.CurrentCamera
    camera.CameraType = Enum.CameraType.Scriptable
end

-- Fonction pour appliquer un filtre
function PhotoModeModule.ApplyFilter(filterName)
    -- Ajouter effet visuel
end

return PhotoModeModule