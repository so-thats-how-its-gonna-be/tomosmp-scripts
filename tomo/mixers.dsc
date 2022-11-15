no_portal:
    type: world
    debug: false
    events:
        on player right clicks end_portal_frame:
            - narrate "<red>The end is disabled right now!"
            - playsound <player> sound:entity_villager_no sound_category:master
            - determine cancelled

no_totems:
    type: world
    events:
        on evoker dies:
            - determine <list[gold_ingot|emerald|diamond|emerald|gold_ingot].random[3]>

blazing_purpose:
    type: world
    events:
        on zombified_piglin spawns because NATURAL:
            - stop if:<util.random_chance[75]>
            - determine passively cancelled
            - spawn blaze <context.location> reason:CUSTOM

no_afk_fishing:
    type: world
    events:
        on player right clicks note_block|iron_trapdoor|*_sign with:fishing_rod:
            - determine passively cancelled
            - explode <player.eye_location> power:1.0 source:<player> if:<util.random_chance[5]>
            - narrate "<bold><red>[EXTREMELY LOUD INCORRECT BUZZER]"
            - playsound <player> sound:entity_chicken_hurt pitch:2 volume:2 sound_category:master
        on fishing_hook interacts with *_plate:
            - determine cancelled
