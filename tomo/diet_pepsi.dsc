diet_pepsi:
    type: item
    material: potion
    display name: <&6><&l>Diet Pepsi
    mechanisms:
        color: <color[black]>
    recipes:
        1:
            type: brewing
            input: water_bottle
            ingredient: echo_shard

diet_pepsi_consume:
    type: world
    debug: false
    events:
        after player consumes diet_pepsi:
            - hurt player cause:MAGIC amount:10
            - cast speed amplifier:5 duration:10s

