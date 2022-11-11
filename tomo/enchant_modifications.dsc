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
            - adjust <context.entity> trades:<context.entity.trades.filter_tag[<[filter_value].result.advanced_matches[item_enchanted:mending].not>]>
