money4mcmmo:
    type: world
    events:
        after mcmmo player levels up skill:
            - stop if:<context.skill.to_lowercase.equals[repair]>
            - wait 30t
            - define money_gain <context.new_level.mul[0.25].add[<util.random.decimal[0].to[1]>].as_money>
            - money give players:<player> quantity:<[money_gain]>
            - narrate "<gold><bold>You earned $<[money_gain]> for reaching level <blue><bold><context.new_level> <gold><bold>in <green><bold><context.skill.to_titlecase><gold><bold>!"
            - playsound <player> sound:entity_experience_orb_pickup volume:1 pitch:1
