money4mcmmo:
    type: world
    debug: false
    events:
        after mcmmo player levels up skill:
            - stop if:<server.flag[tomo.features.mcmmo_cash].not>
            - stop if:<context.skill.equals[repair]>
            - stop if:<player.flag[mcmmo.<context.skill.to_lowercase>.top_level].is_more_than_or_equal_to[<context.new_level>].if_null[false]>
            - flag <player> mcmmo.<context.skill.to_lowercase>.top_level:<context.new_level>
            - wait 15t
            - define money_gain <element[5].as_money>
            - money give players:<player> quantity:<[money_gain]>
            - narrate "<gold><bold>You earned $<[money_gain]> for reaching level <blue><bold><context.new_level> <gold><bold>in <green><bold><context.skill.to_titlecase><gold><bold>!"
            - playsound <player> sound:entity_experience_orb_pickup volume:1 pitch:1

money4fishing:
    type: world
    debug: false
    events:
        on player fishes item bukkit_priority:HIGH:
            - stop if:<server.flag[tomo.features.fishing_bank_notes].not>
            - stop if:<player.mcmmo.level[fishing].is_less_than[30]>
            - if <util.random_chance[10]>:
                - define item <item[bank_note_tiny]>
            - else if <util.random_chance[5]>:
                - define item <item[bank_note_small]>
            - else if <util.random_chance[1]>:
                - define item <item[bank_note_medium]>
            - else if <util.random_chance[0.01]>:
                - define item <item[bank_note_large]>
            - else:
                - stop
            - narrate "<gold><bold>You caught a <reset><[item].display><gold><bold> worth $<[item].flag[money_redeem].as_money>!"
            - determine passively <[item]>

money4farming:
    type: world
    debug: false
    events:
        on player breaks material_flagged:farmable location_flagged:!farming_money_cooldown bukkit_priority:HIGH:
            - stop if:<server.flag[tomo.features.farming_bank_notes].not>
            - stop if:<player.mcmmo.level[herbalism].is_less_than[30]>
            - stop if:<context.material.age.equals[7].not.if_null[true]>
            - flag <context.location> farming_money_cooldown expire:5m
            - if <util.random_chance[1.5]>:
                - define item <item[bank_note_tiny]>
            - else if <util.random_chance[0.5]>:
                - define item <item[bank_note_small]>
            - else if <util.random_chance[0.1]>:
                - define item <item[bank_note_medium]>
            - else:
                - stop
            - narrate "<gold><bold>You found a <reset><[item].display><gold><bold> worth $<[item].flag[money_redeem].as_money> in your <context.material.name>!"
            - determine passively <list_single[<[item]>]>

redeem_cash_note:
    type: world
    debug: false
    events:
        on player right clicks block with:item_flagged:money_redeem:
            - if <server.flag[tomo.features.redeeming_bank_notes].not>:
                - narrate "<red><bold>Bank notes are not allowed to be cashed out right now!"
                - narrate "<red><bold>Ask a staff member for more information."
                - stop
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

no_totems:
    type: world
    debug: false
    events:
        on evoker dies:
            - stop if:<server.flag[tomo.features.no_totems].not>
            - determine <list[gold_ingot|emerald|diamond|bank_note_small|bank_note_tiny].random[3]>

bank_note_custom:
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
