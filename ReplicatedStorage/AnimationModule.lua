-- ModuleScript pour gérer les animations d'attaques
local AnimationModule = {}

-- IDs d'animations (à remplacer par les vrais IDs Roblox)
local animations = {
    ["Sword"] = "rbxassetid://1234567890", -- Animation d'attaque avec épée
    ["Dagger"] = "rbxassetid://1234567891", -- Animation rapide avec dague
    ["Bow"] = "rbxassetid://1234567892", -- Animation de tir à l'arc
    ["Rapier"] = "rbxassetid://1234567893", -- Animation élégante avec rapière
    ["Staff"] = "rbxassetid://1234567894", -- Animation magique avec bâton
    ["Shield"] = "rbxassetid://1234567895", -- Animation défensive
    ["Default"] = "rbxassetid://1234567896" -- Animation par défaut
}

-- Fonction pour jouer une animation d'attaque
function AnimationModule.PlayAttackAnimation(character, weapon)
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local animator = humanoid:FindFirstChild("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
    end
    
    local animId = animations[weapon] or animations["Default"]
    local animation = Instance.new("Animation")
    animation.AnimationId = animId
    animation.Parent = character
    
    local animTrack = animator:LoadAnimation(animation)
    animTrack:Play()
    
    -- Nettoyer après l'animation
    animTrack.Stopped:Connect(function()
        animation:Destroy()
    end)
end

return AnimationModule