money4mcmmo:
    type: world
    events:
        after mcmmo player levels up skill:
            - stop if:<context.skill.equals[repair]>
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
            - flag server money.redeemed_uuids:<list[]> if:<server.has_flag[money.redeemed_uuids].not>
            - if <context.item.flag[money_redeem].is_integer.not> || <context.item.has_flag[uuid].not> || <context.item.script.exists.not> || <server.flag[money.redeemed_uuids].contains[<context.item.flag[uuid]>].if_null[false]>:
                - narrate "<red>Invalid cash note!"
                - narrate "<red>Please report this to an admin!"
                - narrate "<red><&gt> ERROR CODE: 0" if:<context.item.flag[money_redeem].is_integer.not>
                - narrate "<red><&gt> ERROR CODE: 1" if:<context.item.has_flag[uuid].not>
                - narrate "<red><&gt> ERROR CODE: 2" if:<context.item.script.exists.not>
                - narrate "<red><&gt> ERROR CODE: 3" if:<server.flag[money.redeemed_uuids].contains[<context.item.flag[uuid]>].if_null[false]>
                - stop
            - flag server money.redeemed_uuids:->:<context.item.flag[uuid]>
            - take iteminhand quantity:1
            - money give <player> quantity:<context.item.flag[money_redeem]>
            - ~log type:info file:dlogs/money.log "<player.name> redeemed a <context.item.display.strip_color.if_null[unknown bank note]> for $<context.item.flag[money_redeem]>!"
            - narrate "<gold>You redeemed a <context.item.display><reset><gold> for <green>$<context.item.flag[money_redeem]><gold>!"
            - playsound <player> sound:entity_player_levelup volume:1 pitch:2
            - playeffect at:<player.eye_location> effect:item_crack quantity:100 offset:0.5,0.5,0.5 special_data:gold_ingot

bank_note_tiny:
    type: item
    material: paper
    display name: <gold><underline>Tiny Bank Note
    mechanisms:
        hides: all
    enchantments:
        - UNBREAKING:1
    lore:
        - <white>$10.00
        - <white>Right click to redeem.
    flags:
        uuid: <util.random_uuid>
        money_redeem: 10
    allow in material recipes: false

bank_note_small:
    type: item
    material: paper
    display name: <gold><underline>Small Bank Note
    mechanisms:
        hides: all
    enchantments:
        - UNBREAKING:1
    lore:
        - <white>$100.00
        - <white>Right click to redeem.
    flags:
        uuid: <util.random_uuid>
        money_redeem: 100
    allow in material recipes: false

bank_note_medium:
    type: item
    material: book
    display name: <blue><underline>Medium Bank Note
    mechanisms:
        hides: all
    enchantments:
        - UNBREAKING:1
    lore:
        - <white>$1,000.00
        - <white>Right click to redeem.
    flags:
        uuid: <util.random_uuid>
        money_redeem: 1000
    allow in material recipes: false

bank_note_large:
    type: item
    material: book
    display name: <blue><underline>Large Bank Note
    mechanisms:
        hides: all
    enchantments:
        - UNBREAKING:1
    lore:
        - <white>$10,000.00
        - <white>Right click to redeem.
    flags:
        uuid: <util.random_uuid>
        money_redeem: 10000
    allow in material recipes: false
