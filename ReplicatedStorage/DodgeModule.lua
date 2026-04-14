local DodgeModule = {}

-- Module pour gérer le système de roulade/dodge
-- Fonction pour effectuer une roulade
function DodgeModule.Dodge(player)
    if player and player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            -- Animation de roulade (remplacer par une vraie animation)
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://123456789" -- ID d'animation de roulade
            local animator = humanoid:FindFirstChild("Animator") or humanoid:WaitForChild("Animator")
            animator:LoadAnimation(animation):Play()
            
            -- Logique de cooldown (exemple : 2 secondes)
            local cooldown = 2
            player:SetAttribute("DodgeCooldown", true)
            wait(cooldown)
            player:SetAttribute("DodgeCooldown", false)
        end
    end
end

return DodgeModule