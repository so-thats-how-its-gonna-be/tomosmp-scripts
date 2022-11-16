money4mcmmo:
    type: world
    events:
        after mcmmo player levels up skill:
            - stop if:<server.flag[tomo.features.mcmmo_cash].not>
            - stop if:<context.skill.equals[repair]>
            - stop if:<player.flag[mcmmo.<context.skill.to_lowercase>.top_level].is_less_than_or_equal_to[<context.level>].if_null[false]>
            - flag <player> mcmmo.<context.skill.to_lowercase>.top_level:<context.level>
            - wait 15t
            - define money_gain <context.new_level.mul[<element[0.25].add[<util.random.decimal[0].to[1]>]>].as_money>
            - money give players:<player> quantity:<[money_gain]>
            - narrate "<gold><bold>You earned $<[money_gain]> for reaching level <blue><bold><context.new_level> <gold><bold>in <green><bold><context.skill.to_titlecase><gold><bold>!"
            - playsound <player> sound:entity_experience_orb_pickup volume:1 pitch:1

money4fishing:
    type: world
    events:
        on player fishes item bukkit_priority:HIGH:
            - stop if:<server.flag[tomo.features.fishing_bank_notes].not>
            - stop if:<player.mcmmo.level[fishing].is_less_than[30]>
            - if <util.random_chance[5]>:
                - define item <item[bank_note_tiny]>
                - narrate "<gold><bold>You caught a <[item].display><gold><bold> worth $<[item].flag[money_redeem].as_money>!"
                - determine <[item]>
            - else if <util.random_chance[1]>:
                - define item <item[bank_note_small]>
                - narrate "<gold><bold>You caught a <[item].display><gold><bold> worth $<[item].flag[money_redeem].as_money>!"
                - determine <[item]>
            - else if <util.random_chance[0.05]>:
                - define item <item[bank_note_medium]>
                - narrate "<gold><bold>You caught a <[item].display><gold><bold> worth $<[item].flag[money_redeem].as_money>!"
                - determine <[item]>
            - else if <util.random_chance[0.01]>:
                - define item <item[bank_note_large]>
                - narrate "<gold><bold>You caught a <[item].display><gold><bold> worth $<[item].flag[money_redeem].as_money>!"
                - determine <[item]>

redeem_cash_note:
    type: world
    events:
        on player right clicks block with:item_flagged:money_redeem:
            - stop if:<server.flag[tomo.features.redeeming_bank_notes].not>
            - determine passively cancelled
            - flag server money.redeemed_uuids:<list[]> if:<server.has_flag[money.redeemed_uuids].not>
            - if <context.item.flag[money_redeem].is_integer.not> || <context.item.has_flag[uuid].not> || <context.item.script.exists.not> || <server.flag[money.redeemed_uuids].contains[<context.item.flag[uuid]>].if_null[false]>:
                - narrate "<red>Invalid cash note!"
                - narrate "<red>Please report this to an admin!"
                - narrate "<red><&gt> ERROR CODE: 0" if:<context.item.flag[money_redeem].is_integer.not>
                - narrate "<red><&gt> ERROR CODE: 1" if:<context.item.has_flag[uuid].not>
                - narrate "<red><&gt> ERROR CODE: 2" if:<context.item.script.exists.not>
                - narrate "<red><&gt> ERROR CODE: 3" if:<server.flag[money.redeemed_uuids].contains[<context.item.flag[uuid]>].if_null[false]>
                - playsound <player> sound:entity_villager_no volume:1 pitch:1
                - stop
            - flag server money.redeemed_uuids:->:<context.item.flag[uuid]>
            - take iteminhand quantity:1
            - money give <player> quantity:<context.item.flag[money_redeem]>
            - ~log type:info file:dlogs/money.log "<player.name> redeemed a <context.item.display.strip_color.if_null[unknown bank note]> for $<context.item.flag[money_redeem]>!"
            - narrate " "
            - narrate "<gold>You redeemed a <context.item.display><reset><gold> for <green>$<context.item.flag[money_redeem]><gold>!"
            - narrate " "
            - narrate "<gold>Your balance is now <green>$<player.money.as_money><gold>!"
            - narrate " "
            - playsound <player> sound:entity_player_levelup volume:1 pitch:2
            - playeffect at:<player.eye_location> effect:item_crack quantity:100 offset:0.5,0.5,0.5 special_data:<list[emerald|gold_ingot|diamond].random>

bank_note:
    type: item
    material: paper
    display name: <gold><underline>Custom Bank Note
    mechanisms:
        hides: all
    enchantments:
        - UNBREAKING:1
    lore:
        - <white>$<script.data_key[flags].get[money_redeem].as_money>
        - <white>Right click to redeem.
    flags:
        uuid: <util.random_uuid>
        money_redeem: 10
    allow in material recipes: false

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
        - <white>$1000.00
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
        - <white>$10000.00
        - <white>Right click to redeem.
    flags:
        uuid: <util.random_uuid>
        money_redeem: 10000
    allow in material recipes: false
