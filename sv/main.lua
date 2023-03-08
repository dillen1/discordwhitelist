local adaptiveCard = {
    ['type'] = 'AdaptiveCard',
    ['$schema'] = 'http://adaptivecards.io/schemas/adaptive-card.json',
    ['version'] = '1.5',
    ['body'] = {
        {
            ['type'] = 'Image',
            ['$data'] = Config.Settings.card['image'],
            ['url'] = Config.Settings.card['image'],
            ['width'] = '100px',
            ['height'] = '100px',
            ['horizontalAlignment'] = 'center'
        },
        {
            ['type'] = 'TextBlock',
            ['fontType'] = 'Default',
            ['size'] = 'Large',
            ['horizontalAlignment'] = 'center',
            ['text'] = Config.Settings.lang['notWhitelisted']
        },
        {
            ['type'] = 'ActionSet',
            ['actions'] = {
                {
                    ['type'] = 'Action.OpenUrl',
                    ['url'] = Config.Settings.card.discordUrl,
                    ['title'] =  Config.Settings.lang.joinDiscord,
                }
            },
            ['horizontalAlignment'] = 'center'
        }
    }
}

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

            deferrals.presentCard(json.encode(adaptiveCard))
        end
    end, 'GET', '', { 
        ['Content-Type'] = 'application/json',
        ['Authorization'] = ('Bot %s'):format(Config.Settings.discord.botToken)
    })
end)