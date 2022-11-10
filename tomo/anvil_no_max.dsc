anvil_no_max:
    type: world
    events:
        after player prepares anvil craft item:
            - if <context.repair_cost> >= 30:
                - adjust <context.inventory> anvil_repair_cost:29
