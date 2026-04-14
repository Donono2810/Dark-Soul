local DungeonModule = {}

-- Module pour les nouveaux niveaux/donjons
DungeonModule.Dungeons = {
    DarkForest = {Enemies = {"Skeleton", "Wolf"}, Boss = "ForestGuardian"},
    HauntedCastle = {Enemies = {"Ghost", "Knight"}, Boss = "CastleLord"}
}

-- Fonction pour charger un donjon
function DungeonModule.LoadDungeon(dungeonName)
    local dungeon = DungeonModule.Dungeons[dungeonName]
    if dungeon then
        -- Générer les ennemis et le boss
        for _, enemy in ipairs(dungeon.Enemies) do
            -- Créer ennemi
        end
        -- Créer boss
    end
end

return DungeonModule