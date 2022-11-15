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
            - stop if:<util.random_chance[90]>
            - determine passively cancelled
            - spawn blaze <context.location> reason:CUSTOM
