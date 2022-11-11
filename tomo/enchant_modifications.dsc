#This removes the level cap that says "Too expensive!" within anvils, so now there is no enchantment limit!
anvil_no_max:
    type: world
    debug: true
    events:
        on player prepares anvil craft item:
            - if <context.repair_cost> >= 30:
                - adjust <context.inventory> anvil_repair_cost:29
        #Remove mending
        on loot generates:
            - determine LOOT:<inventory[chest].include[<context.items>].exclude_item[item_enchanted:mending].list_contents>
        on player right clicks villager:
            - adjust <context.entity> trades:<context.entity.trades.filter_tag[<[filter_value].result.enchantment_map.keys.contains[mending].not>]>
        on player fishes item_enchanted:mending:
            - determine passively CAUGHT:<item[no_mending]>
            - determine XP:<context.xp.mul[3]>

no_mending:
    type: book
    title: I'm Sorry...
    author: funky493
    text:
    - You would've gotten an item enchanted with mending here, but mending is disabled on this server. :(
