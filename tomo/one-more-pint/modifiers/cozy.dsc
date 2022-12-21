omp_modifier_cozy:
    type: world
    debug: false
    events:
        on entity_flagged:omp.modifiers.cozy changes food level:
            - stop if:<context.item.material.name.equals[cookie].not.if_null[true]>
            - feed <context.entity> amount:5 saturation:3
            - heal 2 <context.entity>
