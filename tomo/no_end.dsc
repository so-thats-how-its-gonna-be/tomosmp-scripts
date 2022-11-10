no_portal:
    type: world
    events:
        on player right clicks end_portal_frame:
            - narrate "The end is disabled right now!"
            - determine cancelled
