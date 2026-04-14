local SkillTreeModule = {}

-- Module pour l'arbre de compétences
SkillTreeModule.Skills = {
    HealthBoost = {Cost = 10, Effect = "+20 HP"},
    DamageBoost = {Cost = 15, Effect = "+10 Dmg"}
}

-- Fonction pour débloquer une compétence
function SkillTreeModule.UnlockSkill(player, skillName)
    local skill = SkillTreeModule.Skills[skillName]
    if skill and player:GetAttribute("SkillPoints") >= skill.Cost then
        player:SetAttribute("SkillPoints", player:GetAttribute("SkillPoints") - skill.Cost)
        -- Appliquer effet
    end
end

return SkillTreeModule