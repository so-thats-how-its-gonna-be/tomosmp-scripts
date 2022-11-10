no_portal:
    type: world
    debug: false
    events:
        on player right clicks end_portal_frame:
            - narrate "The end is disabled right now!"
            - determine cancelled
