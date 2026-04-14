local MagicModule = {}

-- Module pour la magie avancée avec sorts élémentaires
MagicModule.Spells = {
    Fire = {Damage = 40, ManaCost = 30, Effect = "Burn"},
    Ice = {Damage = 35, ManaCost = 25, Effect = "Freeze"},
    Lightning = {Damage = 50, ManaCost = 35, Effect = "Stun"}
}

-- Fonction pour lancer un sort
function MagicModule.CastSpell(player, spellName, target)
    local spell = MagicModule.Spells[spellName]
    if spell and player:GetAttribute("Mana") >= spell.ManaCost then
        player:SetAttribute("Mana", player:GetAttribute("Mana") - spell.ManaCost)
        -- Appliquer dégâts et effet
        if target and target:FindFirstChild("Humanoid") then
            target.Humanoid:TakeDamage(spell.Damage)
            -- Effet spécial (exemple : feu brûle)
            if spell.Effect == "Burn" then
                -- Logique de brûlure
            end
        end
    end
end

return MagicModule