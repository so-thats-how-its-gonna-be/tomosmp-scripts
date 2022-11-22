paper_bark:
    type: item
    material: paper
    no_id: true
    data:
        obtain:
            1:
                type: log_stripping
                input: birch_log
                chance: 100
                quantity: 1-3

paper_bark_drop:
    type: world
    debug: false
    events:
        after player right clicks birch_log|birch_wood with:*_axe:
            - drop <item[paper_bark]> <player.location> quantity:<util.random.int[1].to[3]>
