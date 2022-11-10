anvil_no_max:
    type: world
    events:
        after player prepares anvil craft item:
            - if <context.repair_cost> >= 30:
                - inventory d:<context.inventory> adjust slot:1 repair_cost:29
