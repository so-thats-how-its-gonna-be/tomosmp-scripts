#Discord bot for the server which starts on server start, sends messages to the discord server, and returns messages from the discord server to the minecraft server.

discord_bot:
    type: world
    events:
        after server start:
            - narrate "Nice <context.material>"
