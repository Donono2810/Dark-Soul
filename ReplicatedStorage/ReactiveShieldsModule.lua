local ReactiveShieldsModule = {}

-- Module pour boucliers réactifs
ReactiveShieldsModule.Shields = {
    IronShield = {Absorb = 50, PushForce = 100}
}

-- Fonction pour utiliser le bouclier
function ReactiveShieldsModule.UseShield(player, target)
    local shield = ReactiveShieldsModule.Shields[player:GetAttribute("EquippedShield")]
    if shield then
        -- Absorber dégâts et pousser
    end
end

return ReactiveShieldsModule