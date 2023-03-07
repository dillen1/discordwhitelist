ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    deferrals.defer()

    local discordId = Whitelist:getPlayerDiscordId(source)

    if discordId == nil then deferrals.done(Config.Settings.lang.noDiscord) return end

    PerformHttpRequest(('https://discord.com/api/v8/guilds/%s/members/%s'):format(Config.Settings.discord.discordGuildId, discordId), function(err, data, headers)
        if data then 
            discordData = json.decode(data)

            for _,role in pairs(discordData.roles) do
                if tostring(role) == tostring(Config.Settings.whitelistRole) then 
                    deferrals.done()
                    return
                end
            end

            deferrals.done(Config.Settings.lang.notWhitelisted)
        end
    end, 'GET', '', { 
        ['Content-Type'] = 'application/json',
        ['Authorization'] = ('Bot %s'):format(Config.Settings.discord.botToken)
    })
end)