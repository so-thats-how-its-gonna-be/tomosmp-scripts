no_portal:
    type: world
    debug: false
    events:
        on player right clicks end_portal_frame:
            - stop if:<server.flag[tomo.features.no_end].not>
            - narrate "<red>The end is disabled right now!"
            - playsound <player> sound:entity_villager_no sound_category:master
            - determine cancelled

natural_blazes:
    type: world
    debug: false
    events:
        on zombified_piglin spawns because NATURAL:
            - stop if:<server.flag[tomo.features.natural_blazes].not>
            - stop if:<util.random_chance[90]>
            - determine passively cancelled
            - spawn blaze <context.location> reason:CUSTOM

no_afk_fishing:
    type: world
    debug: false
    events:
        on player right clicks note_block|iron_trapdoor|*_sign with:fishing_rod:
            - stop if:<server.flag[tomo.features.no_afk_fishing].not>
            - determine passively cancelled
            - explode <player.eye_location> power:1.0 source:<player> if:<util.random_chance[5]>
            - narrate "<bold><red>[EXTREMELY LOUD INCORRECT BUZZER]"
            - playsound <player> sound:entity_chicken_hurt pitch:2 volume:2 sound_category:master
        on fishing_hook interacts with *_plate:
            - stop if:<server.flag[tomo.features.no_afk_fishing].not>
            - determine cancelled

#Make minecarts *faster*
better_minecarts:
    type: world
    debug: false
    events:
        after vehicle created:
            - stop if:<context.vehicle.entity_type.advanced_matches[MINECART|*_MINECART].not>
            - stop if:<server.flag[tomo.features.new_minecarts_have_better_speed].not>
            - adjust <context.vehicle> speed:<context.vehicle.speed.mul[2]>

disable_explosions_outside_nether:
    type: world
    debug: false
    events:
        on entity explodes:
            - stop if:<server.flag[tomo.features.disable_explosions_outside_nether].not>
            - stop if:<context.location.world.environment.equals[NETHER]>
            - determine <list[]>
        on block explodes:
            - stop if:<server.flag[tomo.features.disable_explosions_outside_nether].not>
            - stop if:<context.location.world.environment.equals[NETHER]>
            - determine <list[]>

no_fire_tick:
    type: world
    debug: false
    events:
        on block spreads type:fire:
            - stop if:<server.flag[tomo.features.no_fire_tick].not>
            - determine cancelled
        on block burns:
            - stop if:<server.flag[tomo.features.no_fire_tick].not>
            - determine cancelled

no_grind_non_tools:
    type: world
    debug: false
    events:
        on player clicks item in grindstone:
            - stop if:<server.flag[tomo.features.no_grind_non_tools].not>
            - determine cancelled if:<context.item.advanced_matches[recipes_index_dummy]>
            - if <context.item.advanced_matches[fishing_rod|enchanted_book|shears|flint_and_steel|*_axe|*_shovel|*_pickaxe|*_hoe|*_sword|bow|crossbow|air|*_boots|shield|trident|*_chestplate|*_leggings|*_helmet|book].not>:
                - determine cancelled

wolf_no_enviromental_damage:
    type: world
    debug: false
    events:
        on wolf damaged:
            - stop if:<server.flag[tomo.features.wolf_no_enviromental_damage].not>
            - stop if:<context.cause.is_in[BLOCK_EXPLOSION|ENTITY_EXPLOSION|FIRE|FIRE_TICK|LAVA|LIGHTNING|SUFFOCATION|HOT_FLOOR|WITHER|FREEZE|FALL|FALLING_BLOCK].not>
            - determine cancelled

vex_wont_target_villagers:
    type: world
    debug: false
    events:
        on vex targets villager:
            - stop if:<server.flag[tomo.features.vex_wont_target_villagers].not>
            - determine cancelled

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
                    wolf_no_enviromental_damage: true
                    vex_wont_target_villagers: true
                    no_grind_non_tools: true
                - flag server tomo.features:<[features]>
                - foreach <[features]> as:value key:feature:
                    - announce to_console "<&a>Feature <&e><[feature]><&a> set to <&e><[value]><&a>!"
                    - announce to_ops "<&a>Feature <&e><[feature]><&a> set to <&e><[value]><&a>!"
