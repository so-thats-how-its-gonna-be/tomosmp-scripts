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
            - determine LOOT:<inventory[].include[<context.items>].exclude_item[item_enchanted:mending].list_contents>
