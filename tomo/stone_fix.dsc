stone_fix:
    type: world
    events:
        on player breaks stone_slab:
            - stop if:<player.gamemode.equals[CREATIVE]>
            - determine cobblestone if:<context.should_drop_items>
