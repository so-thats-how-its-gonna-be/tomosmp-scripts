no_portal:
    type: world
    debug: false
    events:
        on player right clicks end_portal_frame:
            - stop if:<server.flag[tomo.features.no_end].not>
            - narrate "<red>The end is disabled right now!"
            - playsound <player> sound:entity_villager_no sound_category:master
            - determine cancelled

natural_blazes:
    type: world
    debug: false
    events:
        on zombified_piglin spawns because NATURAL:
            - stop if:<server.flag[tomo.features.natural_blazes].not>
            - stop if:<util.random_chance[90]>
            - determine passively cancelled
            - spawn blaze <context.location> reason:CUSTOM

no_afk_fishing:
    type: world
    debug: false
    events:
        on player right clicks note_block|iron_trapdoor|*_sign with:fishing_rod:
            - stop if:<server.flag[tomo.features.no_afk_fishing].not>
            - determine passively cancelled
            - explode <player.eye_location> power:1.0 source:<player> if:<util.random_chance[5]>
            - narrate "<bold><red>[EXTREMELY LOUD INCORRECT BUZZER]"
            - playsound <player> sound:entity_chicken_hurt pitch:2 volume:2 sound_category:master
        on fishing_hook interacts with *_plate:
            - stop if:<server.flag[tomo.features.no_afk_fishing].not>
            - determine cancelled

#Make minecarts *faster*
better_minecarts:
    type: world
    debug: false
    events:
        after vehicle created:
            - stop if:<context.vehicle.entity_type.advanced_matches[MINECART|*_MINECART].not>
            - stop if:<server.flag[tomo.features.new_minecarts_have_better_speed].not>
            - adjust <context.vehicle> speed:<context.vehicle.speed.mul[2]>

disable_explosions_outside_nether:
    type: world
    debug: false
    events:
        on entity explodes:
            - stop if:<server.flag[tomo.features.disable_explosions_outside_nether].not>
            - stop if:<context.location.world.environment.equals[NETHER]>
            - determine <list[]>
        on block explodes:
            - stop if:<server.flag[tomo.features.disable_explosions_outside_nether].not>
            - stop if:<context.location.world.environment.equals[NETHER]>
            - determine <list[]>

no_fire_tick:
    type: world
    debug: false
    events:
        on block spreads type:fire:
            - stop if:<server.flag[tomo.features.no_fire_tick].not>
            - determine cancelled
        on block burns:
            - stop if:<server.flag[tomo.features.no_fire_tick].not>
            - determine cancelled

no_grind_non_tools:
    type: world
    debug: false
    events:
        on player clicks item in grindstone:
            - if <context.item.advanced_matches[fishing_rod|enchanted_book|shears|flint_and_steel|*_axe|*_shovel|*_pickaxe|*_hoe|*_sword|bow|crossbow|air|*_boots|shield|trident|*_chestplate|*_leggings|*_helmet].not> || <context.inventory.result.is_in[book].not>:
                - determine cancelled

wolf_no_enviromental_damage:
    type: world
    debug: false
    events:
        on wolf damaged:
            - stop if:<context.cause.is_in[BLOCK_EXPLOSION|ENTITY_EXPLOSION|FIRE|FIRE_TICK|LAVA|LIGHTNING|SUFFOCATION|HOT_FLOOR|WITHER|FREEZE|FALL|FALLING_BLOCK].not>
            - determine cancelled
