frag_grenade_entity:
    type: entity
    entity_type: arrow
    mechanisms:
        silent: true
        potion_effects:
            - [type=INVISIBILITY;amplifier=0;duration=20m;ambient=false;particles=false;icon=false]

frag_grenade_entity_disguise:
    type: entity
    entity_type: armor_stand
    mechanisms:
        equipment:
            helmet: frag_grenade
        is_small: true

frag_grenade_entity_events:
    type: world
    debug: false
    events:
        on frag_grenade_entity spawns:
            - disguise <context.entity> as:<entity[frag_grenade_entity_disguise]> global
            - flag <context.entity> thrower:<context.entity.location.find_players_within[5].get[1]>
        on frag_grenade_entity hits block:
            - determine passively cancelled
            - remove <context.projectile>
            - playeffect effect:block_crack at:<context.location> quantity:35 offset:0.5,0.5,0.5 special_data:tnt
            - explode <context.location> power:0.5 fire source:<context.projectile.flag[thrower].if_null[<context.projectile>]>
        on frag_grenade_entity hits entity:
            - determine passively cancelled
            - remove <context.projectile>
            - playeffect effect:block_crack at:<context.hit_entity.location> quantity:35 offset:0.5,0.5,0.5 special_data:tnt
            - explode <context.hit_entity.location> power:0.5 fire source:<context.projectile.flag[thrower].if_null[<context.projectile>]>

frag_grenade:
    type: item
    material: player_head
    display name: <dark_green>Frag Grenade
    mechanisms:
        skull_skin: 1a8e3fdf-eb9b-4cb3-a855-ea9ffbdde4f7|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNzVkMDk2ZjhjNjhlZWMyYTcwMWQxZDVkMmQzMDdjMjdmOGRjYmU4Mzc5ZDAwNTI4YmZiMjg2NGM2NjRjMSJ9fX0=

frag_grenade_events:
    type: world
    debug: false
    events:
        on player right clicks block with:frag_grenade:
            - determine passively cancelled
            - take iteminhand quantity:1 from:<player.inventory>
            - spawn frag_grenade_entity at:<player.eye_location.forward[0.1]> save:entity
            - shoot <entry[entity].spawned_entity> destination:<player.eye_location.forward[10]> speed:0.5 height:0.5
            - playsound <player.eye_location> sound:entity_witch_throw sound_category:master
