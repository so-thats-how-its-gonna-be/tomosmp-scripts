money4mcmmo:
    type: world
    events:
        after mcmmo player levels up skill:
            - stop if:<player.flag[mcmmo.<context.skill.to_lowercase>.top_level].is_less_than_or_equal_to[<context.level>].if_null[false]>
            - flag <player> mcmmo.<context.skill.to_lowercase>.top_level:<context.level>
            - wait 15t
            - define money_gain <context.new_level.mul[<element[0.25].add[<util.random.decimal[0].to[1]>]>].as_money>
            - money give players:<player> quantity:<[money_gain]>
            - narrate "<gold><bold>You earned $<[money_gain]> for reaching level <blue><bold><context.new_level> <gold><bold>in <green><bold><context.skill.to_titlecase><gold><bold>!"
            - playsound <player> sound:entity_experience_orb_pickup volume:1 pitch:1

redeem_cash_note:
    type: world
    events:
        on player right clicks block with:item_flagged:money_redeem:
            - determine passively cancelled
            - if <context.item.flag[money_redeem].is_integer.not> || <context.item.has_flag[uniqueifier].not> || <context.item.script.exists.not>:
                - narrate "<red>Invalid cash note!"
                - narrate "<red>Report this to an admin please!"
                - narrate "<red><&lt> ERROR CODE: 0" if:<context.item.flag[money_redeem].is_integer.not>
                - narrate "<red><&lt> ERROR CODE: 1" if:<context.item.has_flag[uniqueifier].not>
                - narrate "<red><&lt> ERROR CODE: 2" if:<context.item.script.exists.not>
                - stop
            - take iteminhand quantity:1
            - money give <player> quantity:<context.item.flag[money_redeem]>
            - ~log type:info file:dlogs/money.log "<proc[time_format]> <player.name> redeemed a cash note for $<context.item.flag[money_redeem]>!"
            - narrate "<gold>You redeemed a cash note for <green>$<context.item.flag[money_redeem]><gold>!"
            - playsound <player> sound:entity_player_levelup volume:1 pitch:2
            - playeffect at:<player.eye_location> effect:item_crack quantity:100 offset:0.5,0.5,0.5 special_data:gold_ingot

tiny_cash_note:
    type: item
    material: paper
    display name: <gold><underline>Tiny Cash Note
    mechanisms:
        hides: all
    enchantments:
        - UNBREAKING:1
    lore:
        - <white>$10.00
        - <white>Right click to redeem.
    flags:
        uniqueifier: <util.random_uuid>
        money_redeem: 10
    allow in material recipes: false

small_cash_note:
    type: item
    material: paper
    display name: <gold><underline>Small Cash Note
    mechanisms:
        hides: all
    enchantments:
        - UNBREAKING:1
    lore:
        - <white>$100.00
        - <white>Right click to redeem.
    flags:
        uniqueifier: <util.random_uuid>
        money_redeem: 100
    allow in material recipes: false

medium_cash_note:
    type: item
    material: book
    display name: <gold><underline>Medium Cash Note
    mechanisms:
        hides: all
    enchantments:
        - UNBREAKING:1
    lore:
        - <white>$1000.00
        - <white>Right click to redeem.
    flags:
        uniqueifier: <util.random_uuid>
        money_redeem: 1000
    allow in material recipes: false

large_cash_note:
    type: item
    material: book
    display name: <gold><underline>Large Cash Note
    mechanisms:
        hides: all
    enchantments:
        - UNBREAKING:1
    lore:
        - <white>$10000.00
        - <white>Right click to redeem.
    flags:
        uniqueifier: <util.random_uuid>
        money_redeem: 10000
    allow in material recipes: false
