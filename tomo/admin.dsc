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

#fuck
toggle_features:
    type: command
    debug: false
    name: togglefeature
    description: Enable or disable dScript added features
    usage: /togglefeature <&lt>feature|quickclear|destroy<&gt> <&lt>true|false<&gt>
    permission: dscript.tomo.op.togglefeatures
    tab completions:
        1: <server.flag[tomo.features].keys.include[quickclear|destroy]>
        2: <list[true|false]>
    script:
        - if <context.args.get[1]> == quickclear:
            - flag server tomo.features:!
            - reload
            - narrate "<&e>Cleared all features and set them to their default values."
            - stop
        - else if <context.args.get[1]> == destroy:
            - flag server tomo.features:!
            - narrate "<&c>Destroyed all features <bold>without reloading<reset><&c>, this will break something!"
            - stop
        - else if <context.args.size> == 1 && <context.args.get[1]> in <server.flag[tomo.features].keys>:
            - narrate "<&a>Feature <&e><context.args.get[1]><&a> is currently <&e><server.flag[tomo.features].get[<context.args.get[1]>]><&a>."
            - stop
        - else if <context.args.size> == 0:
            - narrate "<&c>No arguments provided."
            - narrate <&c><script.data_key[usage]>
            - stop
        - else if <context.args.size> > 2:
            - narrate "<&c>Too many arguments: <&e><context.args.get[3].to[<context.args.size>]>"
            - narrate <&c><script.data_key[usage]>
            - stop
        - else if <context.args.get[1]> not in <server.flag[tomo.features].keys>:
            - narrate "<&c>Invalid feature: <&e><context.args.get[1]>"
            - narrate <&c><script.data_key[usage]>
            - stop
        - else if <context.args.get[2].is_boolean.not>:
            - narrate "<&c>Invalid value: <&e><context.args.get[2]>"
            - narrate "<&c>Must be <&e>true<&c> or <&e>false<&c>."
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
                    block_drop_fixer: true
                    disable_explosions_outside_nether: true
                    farming_bank_notes: true
                    fishing_bank_notes: true
                    mcmmo_cash: true
                    natural_blazes: true
                    new_minecarts_have_better_speed: true
                    no_afk_fishing: true
                    no_end: true
                    no_fire_tick: true
                    no_mending: true
                    no_totems: true
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
