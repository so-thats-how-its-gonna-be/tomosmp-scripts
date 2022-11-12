money4mcmmo:
    type: world
    events:
        after mcmmo player levels up skill:
            - stop if:<context.skill.to_lowercase.equals[repair]>
            - wait 30t
            - define money_gain <context.new_level.mul[0.25].add[<util.random.decimal[0].to[1]>].as_money>
            - money give players:<player> quantity:<[money_gain]>
            - narrate "<gold>You've earned $<[money_gain]> for reaching level <green><context.new_level> <gold>in <light_purple><context.skill.to_titlecase>!"
