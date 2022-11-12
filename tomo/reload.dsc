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
    events:
        on reload|rl command:
            - stop if:<player.is_op.not>
            - reload
            - narrate "Reloaded Denizen"
            - execute as_player "townyadmin reload"
            - narrate "Reloaded Towny"
            - execute as_player "rtp reload"
            - narrate "Reloaded RTP"
            - execute as_player "essentials reload"
            - narrate "Reloaded Essentials"
            - execute as_player "auctionhouse reload"
            - narrate "Reloaded AuctionHouse"
            - execute as_player "mcmmo reload"
            - narrate "Reloaded McMMO"
