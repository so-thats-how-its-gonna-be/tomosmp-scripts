time_format:
    type: procedure
    script:
        - determine <util.time_now.year>/<util.time_now.month>/<util.time_now.day>/<util.time_now.hour>/<util.time_now.minute>/<util.time_now.second>/<util.time_now.millisecond>

item_name:
    type: procedure
    definitions: name
    script:
        - define item <[name].as[item]>
        - if <[name]> == *_planks:
            - determine "<&r>Any Planks<&r>"
        - else if <[name]> == glowstone:
            - determine "<&r>Glowstone Block<&r>"
        - else:
            - determine <&r><[item].display.if_null[<[item].material.name.replace_text[_].with[ ].to_titlecase>]><&r>

compress_list:
    type: procedure
    definitions: list
    script:
        - define compressed <list>
        - define gone_thru <list>
        - foreach <[list]> as:element:
            - foreach next if:<[gone_thru].contains[<[element]>]>
            - define count <[list].count[<[element]>]>
            - if <[count]> == 1:
                - define compressed:->:<[element]>
            - else:
                - define "compressed:->:<[count]>x <[element]>"
                - define gone_thru:->:<[element]>
        - determine <[compressed]>

flag_events_item:
    type: world
    debug: false
    events:
        on player places item_flagged:no_place:
        - determine cancelled
