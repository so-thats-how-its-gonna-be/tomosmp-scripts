fc_target:
    type: item
    material: target
    no_id: true
    recipes:
        1:
            type: smithing
            base: hay_block
            upgrade: redstone

fc_lectern:
    type: item
    material: lectern
    no_id: true
    recipes:
        1:
            type: smithing
            base: bookshelf
            upgrade: *_planks

fc_redstone_lamp:
    type: item
    material: redstone_lamp
    no_id: true
    recipes:
        1:
            type: smithing
            base: glowstone
            upgrade: redstone

fc_dispenser:
    type: item
    material: dispenser
    no_id: true
    recipes:
        1:
            type: smithing
            base: dropper
            upgrade: bow

fc_observer:
    type: item
    material: observer
    no_id: true
    recipes:
        1:
            type: smithing
            base: repeater
            upgrade: quartz

fc_comparator:
    type: item
    material: comparator
    no_id: true
    recipes:
        1:
            type: smithing
            base: redstone_torch
            upgrade: quartz

fc_repeater:
    type: item
    material: repeater
    no_id: true
    recipes:
        1:
            type: smithing
            base: stone
            upgrade: redstone_torch

fc_note_block:
    type: item
    material: note_block
    no_id: true
    recipes:
        1:
            type: smithing
            base: *_planks
            upgrade: redstone

fc_jukebox:
    type: item
    material: jukebox
    no_id: true
    recipes:
        1:
            type: smithing
            base: *_planks
            upgrade: diamond

fc_hopper:
    type: item
    material: hopper
    no_id: true
    recipes:
        1:
            type: smithing
            base: chest
            upgrade: bucket

fc_bell:
    type: item
    material: bell
    no_id: true
    recipes:
        1:
            type: smithing
            base: gold_block
            upgrade: note_block

smithers_index:
    type: book
    title: <gray>Smither's Index
    author: Smithy
    text:
    - <green><bold>Smither's Index<n><reset>Welcome to the Smither's Index! This is a list of all the new recipes in the game!
    - <green>Target Block<n><gray>Smithing Table<n><reset>Haybale 🔨 Redstone
    - <green>Lectern<n><gray>Bookshelf<n><reset>Planks 🔨 Book
    - <green>Redstone Lamp<n><gray>Glowstone<n><reset>Glowstone 🔨 Redstone
    - <green>Dispenser<n><gray>Dropper<n><reset>Bow 🔨 Chest
    - <green>Observer<n><gray>Repeater<n><reset>Repeater 🔨 Quartz
    - <green>Comparator<n><gray>Redstone Torch<n><reset>Redstone Torch 🔨 Quartz
    - <green>Repeater<n><gray>Stone<n><reset>Redstone Torch 🔨 Stone
    - <green>Note Block<n><gray>Planks<n><reset>Planks 🔨 Redstone
    - <green>Jukebox<n><gray>Planks<n><reset>Planks 🔨 Diamond
    - <green>Hopper<n><gray>Chest<n><reset>Chest 🔨 Bucket
    - <green>Bell<n><gray>Gold Block<n><reset>Gold Block 🔨 Note Block
