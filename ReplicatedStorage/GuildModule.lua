-- ModuleScript pour les guildes
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local GuildModule = {}
local guilds = {}
local playerGuilds = {}
local guildStore = DataStoreService:GetDataStore("DarkSoulGuilds")

function GuildModule.CreateGuild(name, leader)
    if guilds[name] or playerGuilds[leader.UserId] then return false end
    guilds[name] = {leader = leader.UserId, members = {leader.UserId}, points = 0}
    playerGuilds[leader.UserId] = name
    GuildModule.SaveGuilds()
    return true
end

function GuildModule.JoinGuild(player, guildName)
    if not guilds[guildName] or playerGuilds[player.UserId] then return false end
    table.insert(guilds[guildName].members, player.UserId)
    playerGuilds[player.UserId] = guildName
    GuildModule.SaveGuilds()
    return true
end

function GuildModule.LeaveGuild(player)
    local guildName = playerGuilds[player.UserId]
    if not guildName then return false end
    local guild = guilds[guildName]
    for i, memberId in ipairs(guild.members) do
        if memberId == player.UserId then
            table.remove(guild.members, i)
            break
        end
    end
    if #guild.members == 0 then
        guilds[guildName] = nil
    elseif guild.leader == player.UserId then
        guild.leader = guild.members[1] -- New leader
    end
    playerGuilds[player.UserId] = nil
    GuildModule.SaveGuilds()
    return true
end

function GuildModule.AddPoints(guildName, points)
    if guilds[guildName] then
        guilds[guildName].points = guilds[guildName].points + points
        GuildModule.SaveGuilds()
    end
end

function GuildModule.GetGuild(player)
    return playerGuilds[player.UserId]
end

function GuildModule.GetGuildData(guildName)
    return guilds[guildName]
end

function GuildModule.GetAllGuilds()
    return guilds
end

function GuildModule.LoadGuilds()
    local success, data = pcall(function()
        return guildStore:GetAsync("GUILDS")
    end)
    if success and type(data) == "table" then
        guilds = data.guilds or {}
        playerGuilds = data.players or {}
    end
end

function GuildModule.SaveGuilds()
    pcall(function()
        guildStore:SetAsync("GUILDS", {guilds = guilds, players = playerGuilds})
    end)
end

GuildModule.LoadGuilds()

return GuildModule
