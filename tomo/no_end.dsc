no_portal:
    type: world
    debug: false
    events:
        on player right clicks end_portal_frame:
            - narrate "<red>The end is disabled right now!"
            - playsound sound:entity_villager_no sound_category:master
            - determine cancelled
