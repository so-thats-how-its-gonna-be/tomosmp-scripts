smithers_index:
    type: book
    title: <gray>Smither's Index
    author: Smithy
    text:
    - <green><bold>Smither's Index<n><reset>Welcome to the Smither's Index! This is a list of all the new recipes in the game!
    - <green>Target Block<n><gray>Smithing Table<n><reset>Haybale + Redstone
    - <green>Lectern<n><gray>Smithing Table<n><reset>Planks + Book
    - <green>Redstone Lamp<n><gray>Smithing Table<n><reset>Glowstone + Redstone
    - <green>Dispenser<n><gray>Smithing Table<n><reset>Bow + Chest
    - <green>Observer<n><gray>Smithing Table<n><reset>Repeater + Quartz
    - <green>Comparator<n><gray>Smithing Table<n><reset>Redstone Torch + Quartz
    - <green>Repeater<n><gray>Smithing Table<n><reset>Redstone Torch + Stone
    - <green>Note Block<n><gray>Smithing Table<n><reset>Planks + Redstone
    - <green>Jukebox<n><gray>Smithing Table<n><reset>Planks + Diamond
    - <green>Hopper<n><gray>Smithing Table<n><reset>Chest + Bucket
    - <green>Bell<n><gray>Smithing Table<n><reset>Gold Block + Note Block
    - <green>Pointed Dripstone<n><gray>Smithing Table<n><reset>Dripstone Block + Amethyst Shard
    - <green>Tinted Glass<n><gray>Smithing Table<n><reset>Glass + Amethyst Shard
    - <green>Candle<n><gray>Smithing Table<n><reset>Honeycomb + Stick OR String
    - <green>Soul Torch<n><gray>Smithing Table<n><reset>Torch + Soul Sand

smithers_index_item:
    type: item
    material: book
    display name: <gray>Smither's Index
    enchantments:
        - UNBREAKING:1
    mechanisms:
        hides: all
    lore:
        - <gray>Right click while holding to open the Smither's Index!
    recipes:
        1:
            type: smithing
            base: book
            upgrade: redstone

smithers_index_open:
    type: world
    debug: false
    events:
        on player right clicks block with:smithers_index_item:
            - determine passively cancelled
            - adjust <player> show_book:smithers_index
