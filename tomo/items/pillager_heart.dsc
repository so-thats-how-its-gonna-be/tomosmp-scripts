pillager_heart:
    type: item
    material: spider_eye
    display name: <dark_red>Pillager Heart
    lore:
        - <dark_red><italic>Something is wrong.
    enchantments:
        - unbreaking:1
    mechanisms:
        hides: all
    data:
        obtain:
            1:
                type: mob_drop
                input:
                    - pillager
                    - evoker
                    - ravager
                    - vindicator
                #Out of a hundred
                chance: 1
                quantity: 1

pillager_heart_consume:
    type: world
    debug: false
    events:
        after player consumes pillager_heart:
            - determine cancelled if:<player.has_flag[pillager_heart_consumed]>
            - playsound <player.eye_location> sound:entity_warden_angry sound_category:master volume:2 pitch:0.5
            - cast poison <player> amplifier:0 duration:30s
            - cast blindness <player> amplifier:0 duration:30s
            - cast bad_omen <player> duration:<util.int_max> amplifier:2
            - flag <player> pillager_heart_consumed expire:30s
            - while <player.has_flag[pillager_heart_consumed]>:
                - playsound <player.eye_location> sound:entity_warden_heartbeat sound_category:master volume:2 pitch:0.5
                - playeffect at:<player.eye_location> effect:block_crack special_data:crimson_nylium quantity:50 offset:0.5,0.5,0.5
                - wait 1s

pillager_heart_drop:
    type: world
    debug: false
    events:
        on pillager|evoker|ravager|vindicator dies:
            - stop if:<util.random_chance[99]>
            - determine passively <context.drops.include_single[pillager_heart]>
