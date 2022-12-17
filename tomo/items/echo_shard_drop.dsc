echo_shard_drop:
    type: item
    material: echo_shard
    no_id: true
    data:
        obtain:
            1:
                type: mob_drop
                input:
                    - warden
                #Out of a hundred
                chance: 10
                quantity: 1-3

echo_shard_drop_fulfill:
    type: world
    debug: false
    events:
        after warden dies:
            - stop if:<util.random_chance[90]>
            - drop echo_shard_drop <context.entity.eye_location> quantity:<util.random.int[1].to[3]>
