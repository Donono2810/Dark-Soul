local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local leaderboardEvent = ReplicatedStorage:WaitForChild("LeaderboardUpdated")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LeaderboardGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 220)
frame.Position = UDim2.new(1, -270, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Classement PvP"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = frame

local entryLabels = {}
for i = 1, 8 do
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 22)
    label.Position = UDim2.new(0, 5, 0, 30 + (i - 1) * 22)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.Text = i .. ". -"
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    entryLabels[i] = label
end

local function updateLeaderboard(entries)
    for i = 1, #entryLabels do
        local entry = entries[i]
        if entry then
            entryLabels[i].Text = i .. ". " .. entry.name .. " — " .. entry.kills .. " kills"
        else
            entryLabels[i].Text = i .. ". -"
        end
    end
end

leaderboardEvent.OnClientEvent:Connect(updateLeaderboard)
