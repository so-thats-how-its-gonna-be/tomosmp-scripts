money4mcmmo:
    type: world
    events:
        after mcmmo player levels up skill:
            - wait 30t
            - define money_gain <context.new_level.mul[2.15].round_to_precision[0.05]>
            - money give players:<player> quantity:<[money_gain]>
            - narrate "You gained $<[money_gain]> for leveling up <context.skill.to_titlecase>!"
