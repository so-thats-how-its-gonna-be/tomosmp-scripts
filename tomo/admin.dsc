auto_actions:
    type: world
    debug: false
    events:
        after delta time secondly every:30:
            - reload
        after delta time minutely every:5:
            - adjust server save
        after server start:
            - wait 3s
            - reload

#fuck
toggle_features:
    type: command
    name: togglefeature
    description: Enable or disable dScript added features
    usage: /togglefeature <&lt>feature|quickclear<&gt> <&lt>true|false<&gt>
    permission: dscript.tomo.op.togglefeatures
    tab completions:
        1: <server.flag[tomo.features].keys.include[quickclear]>
        2: <list[true|false]>
    script:
        - if <context.args.get[1]> == quickclear:
            - flag server tomo.features:!
            - reload
            - narrate "<&e>Quickcleared all features and set them to their default values."
            - stop
        - else if <context.args.size> < 2:
            - narrate <&c><script.data_key[usage]>
            - stop
        - else if <context.args.get[1]> not in <server.flag[tomo.features]>:
            - narrate "<&c>Invalid feature: <&e><context.args.get[1]>"
            - narrate <&c><script.data_key[usage]>
            - stop
        - else if <context.args.get[2].is_boolean.not>:
            - narrate "<&c>Invalid value: <&e><context.args.get[2]>"
            - narrate <&c><script.data_key[usage]>
            - stop
        - else:
            - flag server tomo.features.<context.args.get[1]>:<context.args.get[2]>
            - narrate "<&a>Feature <&e><context.args.get[1]><&a> set to <&e><context.args.get[2]>!"

define_features:
    type: world
    debug: false
    events:
        after script reload:
            - if <server.has_flag[tomo.features].not>:
                - definemap features:
                    no_end: true
                    natural_blazes: true
                    no_totems: true
                    no_afk_fishing: true
                    block_drop_fixer: true
                    no_mending: true
                    fishing_bank_notes: true
                    mcmmo_cash: true
                    redeeming_bank_notes: true
                - flag server tomo.features:<[features]>
                - foreach <[features]> as:value key:feature:
                    - announce to_console "<&a>Feature <&e><[feature]><&a> set to <&e><[value]><&a>!"
                    - announce to_ops "<&a>Feature <&e><[feature]><&a> set to <&e><[value]><&a>!"

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
