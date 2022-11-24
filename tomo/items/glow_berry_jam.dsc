glow_berry_jam:
    type: item
    material: honey_bottle
    display name: <&color[#F5761A]>Glow Berry Jam
    mechanisms:
        hides: all
    enchantments:
        - unbreaking:1
    lore:
        - <gray>Smear it on something to make it glow!
    recipes:
        1:
            type: brewing
            input: glass_bottle
            ingredient: glow_berries

glow_berry_jam_use:
    type: world
    debug: false
    events:
        on player right clicks living with:glow_berry_jam:
            - ratelimit <player> 1t
            - stop if:<context.entity.has_effect[GLOWING]>
            - take iteminhand quantity:1 from:<player.inventory>
            - give glass_bottle quantity:1 to:<player.inventory>
            - cast GLOWING <context.entity> amplifier:0 duration:180s hide_particles no_icon no_ambient
            - playsound <context.entity.location> sound:block_honey_block_slide pitch:0.5 volume:2.0 sound_category:master
        on player consumes glow_berry_jam:
            - determine passively cancelled
            - take iteminhand quantity:1 from:<player.inventory>
            - give glass_bottle quantity:1 to:<player.inventory>
            - cast GLOWING <player> amplifier:0 duration:180s hide_particles no_icon no_ambient
            - playsound <player.location> sound:block_honey_block_slide pitch:0.5 volume:2.0 sound_category:master

glow_berry_jam_cooked_bread:
    type: item
    material: bread
    display name: <&color[#F28500]>Glow Berry Jam Toast
    mechanisms:
        hides: all
    enchantments:
        - unbreaking:1
    lore:
        - <gray>Strange, but tasty.
    recipes:
        1:
            type: brewing
            input: cooked_bread
            ingredient: glow_berry_jam

glow_berry_jam_cooked_bread_use:
    type: world
    debug: false
    events:
        on player changes food level item:glow_berry_jam_cooked_bread:
            - determine passively <context.food.add[2].min[20]>
            - cast GLOWING <player> amplifier:0 duration:180s hide_particles no_icon no_ambient

ender_berry_jam:
    type: item
    material: potion
    display name: <&color[#8B4000]>Ender Berry Jam
    mechanisms:
        color: <color[#8B4000]>
    lore:
        - <gray>Sweet and sour.
    recipes:
        1:
            type: brewing
            input: glow_berry_jam
            ingredient: ender_pearl

ender_berry_jam_use:
    type: world
    debug: false
    events:
        on player consumes ender_berry_jam:
            - determine passively cancelled
            - take iteminhand quantity:1 from:<player.inventory>
            - give glow_berry_jam quantity:1 to:<player.inventory>
            - define targets <player.location.find.living_entities.within[25]>
            - cast GLOWING <[targets]> amplifier:0 duration:60s hide_particles no_icon no_ambient
            - playsound <player.location> sound:entity_enderman_teleport pitch:0.5 volume:2.0 sound_category:master
            - playsound <[targets].parse_tag[<[parse_value].location>]> sound:block_honey_block_slide pitch:0.5 volume:2.0 sound_category:master

ender_berry_jam_cooked_bread:
    type: item
    material: bread
    display name: <&color[#ff8c00]>Ender Berry Jam Toast
    mechanisms:
        hides: all
    enchantments:
        - unbreaking:1
    lore:
        - <gray>Sweet, sour, and a little bit of transdimensional foolishness.
    recipes:
        1:
            type: brewing
            input: cooked_bread
            ingredient: ender_berry_jam
        2:
            type: brewing
            input: glow_berry_jam_cooked_bread
            ingredient: ender_pearl

ender_berry_jam_cooked_bread_use:
    type: world
    debug: false
    events:
        on player changes food level item:ender_berry_jam_cooked_bread:
            - determine passively <context.food.add[2].min[20]>
            - define targets <player.location.find.living_entities.within[35]>
            - cast GLOWING <[targets]> amplifier:0 duration:120s hide_particles no_icon no_ambient
            - playsound <player.location> sound:entity_enderman_teleport pitch:0.5 volume:2.0 sound_category:master
            - playsound <[targets].parse_tag[<[parse_value].location>]> sound:block_honey_block_slide pitch:0.5 volume:2.0 sound_category:master
