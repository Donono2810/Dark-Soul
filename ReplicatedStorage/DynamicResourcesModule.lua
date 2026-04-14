local DynamicResourcesModule = {}

-- Module pour ressources dynamiques
DynamicResourcesModule.Resources = {
    IronOre = {Rarity = "Common", RespawnTime = 300}
}

-- Fonction pour collecter une ressource
function DynamicResourcesModule.CollectResource(player, resourceName)
    local resource = DynamicResourcesModule.Resources[resourceName]
    if resource then
        -- Ajouter à l'inventaire
        -- Programmer respawn
    end
end

return DynamicResourcesModule