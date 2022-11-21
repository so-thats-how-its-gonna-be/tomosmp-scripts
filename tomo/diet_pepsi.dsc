diet_pepsi:
    type: item
    material: potion
    display name: <&6><&l>Diet Pepsi
    mechanisms:
        color: <color[black]>
    recipes:
        1:
            type: brewing
            input: glass_bottle
            ingredient: echo_shard

diet_pepsi_consume:
    type: world
    debug: false
    events:
        after player consumes diet_pepsi:
            - hurt 10 <player> cause:MAGIC
            - cast speed amplifier:5 duration:30s

