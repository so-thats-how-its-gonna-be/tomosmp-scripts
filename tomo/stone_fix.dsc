stone_fix:
    type: world
    events:
        on player breaks stone_slab:
            - determine cobblestone if:<context.should_drop_items>
