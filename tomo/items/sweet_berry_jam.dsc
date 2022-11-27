sweet_berry_jam:
    type: item
    material: potion
    display name: <&color[#ff0800]>Sweet Berry Jam
    mechanisms:
        hides: all
        color: <color[#ff0800]>
    enchantments:
        - unbreaking:1
    lore:
        - <gray>Tastes like pure sugar!
    recipes:
        1:
            type: brewing
            input: glass_bottle
            ingredient: sweet_berries

sweet_berry_jam_use:
    type: world
    debug: false
    events:
        on player consumes sweet_berry_jam:
            - cast REGENERATION amplifier:2 duration:5s
            - cast SATURATION amplifier:2 duration:5s

sweet_berry_jam_cooked_bread:
    type: item
    material: bread
    display name: <&color[#ff0800]>Sweet Berry Jam Toast
    mechanisms:
        hides: all
    enchantments:
        - unbreaking:1
    lore:
        - <gray>The bread <italic>slightly<reset><gray> offsets the sweetness of the jam.
    recipes:
        1:
            type: brewing
            input: cooked_bread
            ingredient: sweet_berry_jam

sweet_berry_jam_cooked_bread_use:
    type: world
    debug: false
    events:
        on player consumes sweet_berry_jam_cooked_bread:
            - cast REGENERATION amplifier:2 duration:5s
            - cast SATURATION amplifier:2 duration:5s
