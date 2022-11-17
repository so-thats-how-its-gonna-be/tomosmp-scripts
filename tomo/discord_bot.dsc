#Discord bot for the server which starts on server start, sends messages to the discord server, and returns messages from the discord server to the minecraft server.

discord_bot:
    type: world
    debug: false
    events:
        after server start:
            - ~discordconnect id:tomobot token:<secret[tomobot_token]>
            - define message "**Server started!**"
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
        after player chats:
            - define message "`<player.name>`: <context.message>"
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
        after discord message received:
            - stop if:<context.author.id.equals[<server.flag[tomobot.self_id]>]>
            - stop if:<context.channel.id.equals[<server.flag[tomobot.chat_link_channel]>].not>
            - define message "<dark_aqua>[Discord] <white><context.author.name>: <white><context.message.text>"
            - announce <[message]>
            - announce to_console <[message]>
