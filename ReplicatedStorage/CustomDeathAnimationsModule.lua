local CustomDeathAnimationsModule = {}

-- Module pour animations de mort personnalisées
CustomDeathAnimationsModule.Animations = {
    Fall = "rbxassetid://111",
    Burn = "rbxassetid://222"
}

-- Fonction pour jouer animation de mort
function CustomDeathAnimationsModule.PlayDeathAnimation(character, cause)
    local anim = Instance.new("Animation")
    anim.AnimationId = CustomDeathAnimationsModule.Animations[cause]
    local animator = character.Humanoid:FindFirstChild("Animator")
    animator:LoadAnimation(anim):Play()
end

return CustomDeathAnimationsModule