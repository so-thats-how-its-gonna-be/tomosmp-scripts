stone_fix:
    type: world
    events:
        after player breaks stone_slab:
        - determine <item[cobblestone]> if:<context.should_drop_items>
