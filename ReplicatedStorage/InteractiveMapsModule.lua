local InteractiveMapsModule = {}

-- Module pour cartes interactives
InteractiveMapsModule.Markers = {} -- Liste des marqueurs

-- Fonction pour ajouter un marqueur
function InteractiveMapsModule.AddMarker(position, type, description)
    table.insert(InteractiveMapsModule.Markers, {Pos = position, Type = type, Desc = description})
end

-- Fonction pour afficher la carte
function InteractiveMapsModule.DisplayMap(player)
    -- Créer GUI de carte
end

return InteractiveMapsModule