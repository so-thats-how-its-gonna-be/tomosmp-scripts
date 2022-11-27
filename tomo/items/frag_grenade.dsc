frag_grenade_entity:
    type: entity
    debug: false
    entity_type: snowball
    mechanisms:
        silent: true
        item: frag_grenade

frag_grenade_dropped_entity:
    type: entity
    debug: false
    entity_type: dropped_item
    mechanisms:
        silent: true
        item: frag_grenade
        pickup_delay: 500m
        invulnerable: true
    flags:
        uuid: <util.random_uuid>

frag_grenade_summon_dropped_item:
    type: task
    debug: false
    definitions: location|projectile
    script:
        - remove <[projectile]>
        - spawn frag_grenade_dropped_entity at:<[location]> save:grenade
        - define grenade <entry[grenade].spawned_entity>
        - repeat 4:
            - stop if:<[grenade].is_spawned.not.if_null[true]>
            - playsound <[grenade].location> sound:block_dispenser_fail sound_category:master volume:2 pitch:<[value].mul[0.5]>
            - wait 1s
        - stop if:<[grenade].is_spawned.not.if_null[true]>
        - define grenade_location <[grenade].location>
        - remove <[grenade]>
        - playeffect effect:block_crack at:<[grenade_location]> quantity:35 offset:0.5,0.5,0.5 special_data:tnt
        - explode <[grenade_location]> power:2.0 fire source:<[projectile].flag[thrower]>

frag_grenade_entity_events:
    type: world
    debug: false
    events:
        on frag_grenade_entity spawns:
            - flag <context.entity> thrower:<context.entity.location.find_players_within[5].get[1].if_null[<context.projectile>]>
        on frag_grenade_entity hits block:
            - determine passively cancelled
            - run frag_grenade_summon_dropped_item def:<context.location.center.above[1.2]>|<context.projectile>
        on frag_grenade_entity hits entity:
            - determine passively cancelled
            - run frag_grenade_summon_dropped_item def:<context.entity.location.center.above[1.2]>|<context.projectile>

frag_grenade:
    type: item
    debug: false
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
            - shoot <entry[entity].spawned_entity> destination:<player.eye_location.forward[20]> speed:0.5 height:0.5
            - playsound <player.eye_location> sound:entity_witch_throw sound_category:master pitch:0.5 volume:2
