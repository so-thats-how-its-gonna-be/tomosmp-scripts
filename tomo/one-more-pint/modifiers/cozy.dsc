omp_modifier_cozy:
    type: world
    debug: false
    events:
        on entity_flagged:omp.modifiers.cozy changes food level:
            - stop if:<context.item.material.name.equals[cookie].not.if_null[true]>
            - heal 4 <context.entity>
            - repeat 7:
                - wait 5t
                - feed <context.entity> amount:1 saturation:1
