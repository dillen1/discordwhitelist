# Discord Whitelist
A very simple discord whitelist script I made because I was bored and wanted to learn a little how the discord apis work

# Config File
```lua
Config.Settings = {
    discord = {
        discordGuildId = , -- https://gyazo.com/5aa52f81977372e26f75c9ce07db7c83.
        botToken = "", -- You have to create a bot here (https://discord.com/developers/applications) then add it into your server and copy the bot token and paste it where its blank.
    },

    whitelistRole = , -- What role that have access to your the server (https://gyazo.com/fc9677afd09e62fceea3a4115e108c7a)

    lang = {
        notWhitelisted = "You are not whitelisted on (Server Name)",
        checkConnection = "Check that you have connected your discord with FiveM"
    }
}
```
