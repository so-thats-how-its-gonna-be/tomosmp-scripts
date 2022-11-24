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
            input: bottle
            ingredient: glow_berries

glow_berry_jam_use:
    type: world
    debug: false
    events:
        on player right clicks living with:glow_berry_jam:
            - ratelimit <player> 1t
            - stop if:<context.entity.has_effect[GLOWING]>
            - take iteminhand quantity:1 from:<player.inventory>
            - cast GLOWING <context.entity> amplifier:0 duration:180s hide_particles no_icon no_ambient
            - playsound <context.entity.location> sound:block_honey_block_slide pitch:0.5 volume:2.0 sound_category:master
        on player consumes glow_berry_jam:
            - determine passively cancelled
            - take iteminhand quantity:1 from:<player.inventory>
            - give glass_bottle quantity:1 to:<player.inventory>
            - cast GLOWING <player> amplifier:0 duration:180s hide_particles no_icon no_ambient
