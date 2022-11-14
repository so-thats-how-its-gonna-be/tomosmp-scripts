auto_actions:
    type: world
    debug: false
    events:
        after delta time secondly every:30:
            - reload
        after delta time minutely every:5:
            - adjust server save

reload_override:
    type: world
    debug: false
    events:
        on reload|rl command:
            - determine passively FULFILLED
            - stop if:<player.is_op.not>
            - reload
            - narrate "Reloaded Denizen"
            - wait <util.random.int[1].to[5]>t
            - execute as_op "townyadmin reload all"
            - narrate "Reloaded Towny"
            - wait <util.random.int[1].to[5]>t
            - execute as_op "rtp reload"
            - narrate "Reloaded RTP"
            - wait <util.random.int[1].to[5]>t
            - execute as_op "essentials reload"
            - narrate "Reloaded Essentials"
            - wait <util.random.int[1].to[5]>t
            - execute as_op "auctionhouse reload"
            - narrate "Reloaded AuctionHouse"
            - wait <util.random.int[1].to[5]>t
            - execute as_op "mcmmo reload"
            - narrate "Reloaded McMMO"
            - wait <util.random.int[1].to[5]>t
            - execute as_op "graves reload"
            - narrate "Reloaded Graves"
            - wait <util.random.int[1].to[5]>t
            - narrate "<green><bold>Reloaded all plugins! :)"
