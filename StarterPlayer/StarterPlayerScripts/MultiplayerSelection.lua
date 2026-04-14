local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local setModeEvent = ReplicatedStorage:WaitForChild("SetMultiplayerMode")
local modeChangedEvent = ReplicatedStorage:WaitForChild("MultiplayerModeChanged")
local modeValue = ReplicatedStorage:WaitForChild("MultiplayerMode")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MultiplayerModeGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 180)
frame.Position = UDim2.new(1, -280, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 28)
title.BackgroundTransparency = 1
title.Text = "Mode Multijoueur"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

local function createButton(text, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 36)
    button.Position = UDim2.new(0, 10, 0, y)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Parent = frame
    return button
end

local coopButton = createButton("Coop", 36)
local pvpButton = createButton("PvP", 76)
local soloButton = createButton("Solo", 116)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 152)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 14
statusLabel.Text = "Mode actuel : " .. modeValue.Value
statusLabel.Parent = frame

coopButton.MouseButton1Click:Connect(function()
    setModeEvent:FireServer("Coop")
end)
pvpButton.MouseButton1Click:Connect(function()
    setModeEvent:FireServer("PvP")
end)
soloButton.MouseButton1Click:Connect(function()
    setModeEvent:FireServer("Solo")
end)

local function updateStatus(mode)
    statusLabel.Text = "Mode actuel : " .. mode
end

modeChangedEvent.OnClientEvent:Connect(updateStatus)
updateStatus(modeValue.Value)