enchantment_mods:
    type: world
    debug: true
    events:
        #This removes the level cap that says "Too expensive!" within anvils, so now there is no enchantment limit!
        on player prepares anvil craft item:
            - if <context.repair_cost> >= 30:
                - adjust <context.inventory> anvil_repair_cost:29

        #Remove mending
        on loot generates:
            - determine LOOT:<inventory[chest].include[<context.items>].exclude_item[item_enchanted:mending].list_contents>
        on player right clicks villager:
            - adjust <context.entity> trades:<context.entity.trades.filter_tag[<[filter_value].result.enchantment_map.keys.contains[mending].not>]>
        on player fishes item_enchanted:mending:
            - determine passively CAUGHT:<item[emerald].with[display=<green>Pity Emerald]>
            - determine XP:<context.xp.mul[5]>
