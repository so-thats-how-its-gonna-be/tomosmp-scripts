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

pillager_heart_consume:
    type: world
    debug: false
    events:
        after player consumes pillager_heart:
            - playsound <player.eye_location> sound:entity_warden_heartbeat sound_category:master volume:2 pitch:0.5
            - cast poison <player> amplifier:0 duration:60s
            - cast blindness <player> amplifier:0 duration:60s
            - cast bad_omen <player> duration:<util.int_max> amplifier:2
