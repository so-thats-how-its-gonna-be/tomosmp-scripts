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
            - stop if:<context.new_message.author.id.equals[<server.flag[tomobot.self_id]>]>
            - stop if:<context.channel.id.equals[<server.flag[tomobot.chat_link_channel]>].not>
            - if <context.new_message.text.starts_with[b!]> && <context.new_message.author.permissions[<context.new_message.channel.group>].contains_any[administrator]>:
                - define command <context.new_message.text.after[b!].split_args>
                - choose <[command].get[1]>:
                    - case execute:
                        - execute as_server <[command].get[2]>
                        - ~discordmessage id:tomobot channel:<context.channel.id> "Executed `<[command].get[2]>`"
                        - stop
                    - case reload:
                        - reload
                        - ~discordmessage id:tomobot channel:<context.channel.id> Reloaded!
                        - stop
                    - case kick:
                        - kick <[command].get[2]> reason:<[command].get[3].if_null[]>
                        - ~discordmessage id:tomobot channel:<context.channel.id> "Kicked `<[command].get[2]>` with reason `<[command].get[3]>`!"
                        - stop
            - define message "<dark_aqua>[Discord] <white><context.new_message.author.name>: <white><context.new_message.text_display>"
            - announce <[message]>
            - announce to_console <[message]>
        after player dies:
            - define message `<context.message.strip_color>`
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
        after player joins:
            - define message `<context.message.strip_color>`
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
        after player quits:
            - define message `<context.message.strip_color>`
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
        on shutdown:
            - define message "`Server stopped!`"
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
