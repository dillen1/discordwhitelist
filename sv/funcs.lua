Whitelist = {}

function Whitelist:getPlayerDiscordId(playerId)
    for _, identifier in ipairs(GetPlayerIdentifiers(playerId)) do
        if string.match(identifier, "^discord:") then
            self.discordId = string.sub(identifier, 9)
            break
        end
    end
    
    return self.discordId
end