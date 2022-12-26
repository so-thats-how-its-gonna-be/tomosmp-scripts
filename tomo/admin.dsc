auto_actions:
    type: world
    debug: false
    events:
        #after delta time secondly every:30:
        #    - reload
        after delta time minutely every:5:
            - adjust server save
        after server start:
            - wait 3s
            - reload

reload_override:
    type: world
    debug: false
    events:
        on reload|rl command:
            - determine passively FULFILLED
            - stop if:<player.is_op.not>
            - run reload_as_server
            - narrate "<green><bold>Reloaded all plugins! :)"

reload_as_server:
    type: task
    script:
    - reload
    - execute as_server "townyadmin reload all"
    - execute as_server "rtp reload"
    - execute as_server "essentials reload"
    - execute as_server "auctionhouse reload"
    - execute as_server "mcmmo reload"
    - execute as_server "graves reload"
    - execute as_server "co reload"
    - execute as_server "geyser reload"
