cooked_bread:
    type: item
    material: bread
    display name: <gray><&dq>Toast<&dq>
    mechanisms:
        hides: all
    enchantments:
        - unbreaking:1
    lore:
        - <gray><bold>You probably burnt it.
    recipes:
        1:
            type: furnace
            input: bread

cooked_bread_consume:
    type: world
    debug: false
    events:
        on player changes food level item:cooked_bread:
            - determine passively <context.food.add[1].min[20]>
