#Discord bot for the server which starts on server start, sends messages to the discord server, and returns messages from the discord server to the minecraft server.

discord_bot:
    type: world
    debug: false
    events:
        after server start:
            - ~discordconnect id:tomobot token:<secret[tomobot_token]>
            - define message "__Server started!__"
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
        after player chats:
            - define message "`<player.name>`: <context.message>"
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
        after discord message received:
            - stop if:<context.new_message.author.id.equals[<server.flag[tomobot.self_id]>]>
            - stop if:<context.channel.id.equals[<server.flag[tomobot.chat_link_channel]>].not>
            - if <context.new_message.text.starts_with[b!]> && <context.new_message.author.permissions[<context.new_message.channel.group>].contains_any[administrator]>:
                - define full_command <context.new_message.text.after[b!]>
                - define command <[full_command].split[ ].get[1]>
                - define args <[full_command].split.remove[1]>
                - choose <[command]>:
                    - case execute ex e:
                        - execute as_server <[args].space_separated>
                        - ~discordmessage id:tomobot channel:<context.channel.id> "Executed: <n>`/<[args].space_separated>`<n>Check console for output."
                        - stop
                    - case reload rl:
                        - run reload_as_server
                        - ~discordmessage id:tomobot channel:<context.channel.id> Reloaded!
                        - stop
                    - case kick:
                        - kick <[args].get[1]> reason:<[args].remove[1].space_separated>
                        - ~discordmessage id:tomobot channel:<context.channel.id> "Kicked `<[args].get[1]>` with reason `<[args].remove[1].space_separated>`!"
                        - stop
                    - case ban:
                        - ban add <[args].get[1]> reason:<[args].remove[1|2].space_separated> expire:<[args].get[2].as[duration]>
                        - ~discordmessage id:tomobot channel:<context.channel.id> "Banned `<[args].get[1]>` for `<[args].get[2].as[duration].formatted_words>` with reason `<[args].remove[1|2].space_separated>`!"
                        - stop
                    - case unban:
                        - ban remove <[args].get[1]>
                        - ~discordmessage id:tomobot channel:<context.channel.id> "Unbanned `<[args].get[1]>`!"
                        - stop
                    - case banip:
                        - ban add addresses:<server.match_offline_player[<[args].get[1]>].ip_address> reason:<[args].remove[1|2].space_separated> expire:<[args].get[2].as[duration]>
                        - ~discordmessage id:tomobot channel:<context.channel.id> "Banned player IP `<[args].get[1]>` for `<[args].get[2].as[duration].formatted_words>` with reason `<[args].remove[1|2].space_separated>`!"
                        - stop
                    - case smite:
                        - strike <server.match_player[<[args].get[1]>].location>
                        - ~discordmessage id:tomobot channel:<context.channel.id> "Struck `<[args].get[1]>` with the force of the sun!"
                        - stop

            - if <context.new_message.text.starts_with[b!]>:
                - define full_command <context.new_message.text.after[b!]>
                - define command <[full_command].split[ ].get[1]>
                - define args <[full_command].split.remove[1]>
                - choose <[command]>:
                    - case players online p list:
                        - define player_list <server.online_players.parse_tag[<[parse_value].name>]>
                        - ~discordmessage id:tomobot channel:<context.channel.id> "Online players: <n>`<[player_list].separated_by[`, `]>`"
                        - stop

            - define message "<dark_aqua>[Discord] <white><context.new_message.author.name>: <white><context.new_message.text_display>"
            - announce <[message]>
            - announce to_console <[message]>
        after player dies:
            - define message __<context.message.strip_color.replace_text[<player.name>].with[`<player.name>`].replace_text[regex:<&ss>\<&lb>.*\<&rb>]>__
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
        after player joins:
            - define message __<context.message.strip_color.replace_text[<player.name>].with[`<player.name>`]>__
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
        after player quits:
            - define message __<context.message.strip_color.replace_text[<player.name>].with[`<player.name>`]>__
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
        on shutdown:
            - define message "__Server stopped!__"
            - ~discordmessage id:tomobot channel:<server.flag[tomobot.chat_link_channel]> <[message]>
