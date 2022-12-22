omp_data:
    type: data
    omp:
        global_tolerance: 2
        effects:
            blindness:
                duration: 2s-15s
                amplifier: 1-3
            confusion:
                duration: 5s-15s
                amplifier: 1
            hunger:
                duration: 10s-15s
                amplifier: 1-3
            darkness:
                duration: 5s-15s
                amplifier: 1-3
            slow:
                duration: 5s
                amplifier: 1
            increase_damage:
                duration: 5s-15s
                amplifier: 1-3
            weakness:
                duration: 5s-15s
                amplifier: 1-2

omp_tick:
    type: world
    debug: false
    events:
        after delta time secondly:

            - define omp_data <script[omp_data].data_key[omp]>

            - foreach <server.online_players> as:__player:

                - if <player.has_flag[omp.drunkness.level].not> || <player.flag[omp.drunkness.level]> < 0:
                    - flag <player> omp.drunkness.level:0

                - define drunkness <player.flag[omp.drunkness.level]>

                - if <util.random_chance[30]> && <[drunkness]> > 0:
                    - flag <player> omp.drunkness.level:<[drunkness].sub[<util.random.decimal[0].to[0.1]>].max[0]>

                - foreach next if:<[drunkness].is_less_than[<[omp_data.global_tolerance]>]>
                - foreach next if:<player.location.exists.not>

                - if <util.random_chance[<[drunkness].sub[1].mul[3]>]>:
                    - define effect <[omp_data.effects].keys.random>
                    - define duration <duration[<[omp_data.effects.<[effect]>.duration]>]>
                    - define amplifier <[omp_data.effects.<[effect]>.amplifier].proc[omp_rand_range].round.sub[1]>
                    - cast <[effect]> <player> amplifier:<[amplifier]> duration:<[duration]> if:<player.has_effect[<[effect]>].not>

                - if <[drunkness]> > 10 && <util.random_chance[<[drunkness].sub[9]>]>:
                    - hurt <player> 1 cause:MAGIC source:<player>
                    - playsound <player> sound:block_brewing_stand_brew sound_category:PLAYERS pitch:2 volume:0.5
                    - flag <player> omp.drunkness.level:-:<util.random.decimal[0].to[2]>

                - if <[drunkness]> > 20 && <util.random_chance[<[drunkness].sub[19]>]>:
                    - playsound <player.location> sound:entity_donkey_hurt sound_category:PLAYERS pitch:0.5 volume:2
                    - flag <player> omp.drunkness.level:-:<util.random.decimal[0].to[5]>
                    - define vomit <entity[area_effect_cloud].with[base_potion=poison,false,false;particle_color=green;radius=3;radius_on_use=-0.2;radius_per_tick=-0.01;source=<player>;wait_time=0.5s]>
                    - spawn <[vomit]> <player.location.center>

                - if <[drunkness]> > 100:
                    - explode <player.eye_location> power:2.0 source:<player>
                    - define vomit <entity[area_effect_cloud].with[base_potion=poison,false,false;particle_color=green;radius=10;radius_on_use=-0;radius_per_tick=-0.01;source=<player>;wait_time=0.1s]>
                    - spawn <[vomit]> <player.location.center>
                    - kill <player>
                    - flag <player> omp.drunkness.level:-:<util.random.decimal[50].to[100]>

omp_reload:
    type: world
    debug: false
    events:
        after reload scripts:
            - flag server omp.modifier_ids:<util.scripts.filter_tag[<[filter_value].name.starts_with[omp_modifier_]>].parse_tag[<[parse_value].name>]>

omp_modifier_apply:
    type: task
    debug: false
    definitions: player|modifier_id|duration
    script:
        - if <[duration].exists>:
            - flag <[player]> omp.modifier.<[modifier_id]> expire:<[duration]>
        - else:
            - flag <[player]> omp.modifier.<[modifier_id]>:!

omp_modifier_remove:
    type: task
    debug: false
    definitions: player|modifier_id
    script:
        - flag <[player]> omp.modifier.<[modifier_id]>:!

omp_command_modifier:
    type: command
    name: ompmodifier
    description: Apply or remove a modifier to a player.
    usage: /ompmodifier <&lt>apply|remove<&gt> <&lt>modifier<&gt> <&lt>player<&gt> <&lt>duration<&gt>
    tab completions:
        1: apply|remove
        2: <server.flag[omp.modifier_ids]>
        3: <server.online_players.parse_tag[<[parse_value].name>]>
    permission: omp.command.modifier
    script:
        - define args <context.args>
        - if <[args].size> > 4 || <[args].size> < 3:
            - narrate "<&c>Invalid argument count! Usage: <script.data_key[usage]>"
            - stop
        - define modifier <[args].get[2]>
        - if <[args].get[2].is_in[<server.flag[omp_modifier_ids]>].not>:
            - narrate "<&c>Invalid modifier ID! Valid IDs: <&nl><white><server.flag[omp.modifier_ids].separated_by[<&nl>]>"
            - stop
        - define target <server.match_player[<[args].get[3]>]>
        - if <[target].exists.not>:
            - narrate "<&c>Invalid player <&dq><[args].get[3]><&dq>!"
            - stop
        - if <[args].get[1]> == apply:
            - if <[args].get[4].exists.not>:
                - run omp_modifier_apply def.player:<[target]> def.modifier_id:<[modifier]>
                - narrate "<&a>Applied modifier <&dq><[modifier]><&dq> to <[target].name>!"
            - else:
                - define duration <duration[<[args].get[4]>]>
                - run omp_modifier_apply def.player:<[target]> def.modifier_id:<[modifier]> def.duration:<[duration]>
                - narrate "<&a>Applied modifier <&dq><[modifier]><&dq> to <[target].name> for <[duration].formatted>!"
        - else if <[args].get[1]> == remove:
            - if <[target].has_flag[omp.modifier.<[modifier]>]>:
                - run omp_modifier_remove def.player:<[target]> def.modifier_id:<[modifier]>
                - narrate "<&a>Removed modifier <&dq><[modifier]><&dq> from <[target].name>!"
            - else:
                - narrate "<&c><[target].name> does not have modifier <&dq><[modifier]><&dq>!"
        - else:
            - narrate "<&c>Invalid action <&dq><[args].get[1]><&dq>! Usage: <script.data_key[usage]>"

omp_drink:
    type: world
    debug: false
    events:
        after player consumes item_flagged:omp.drink.strength:
            - choose <context.item.flag[omp.drink.type]>:
                - case add:
                    - flag <player> omp.drunkness.level:<player.flag[omp.drunkness.level].if_null[0].add[<context.item.flag[omp.drink.strength].proc[omp_rand_range]>]>
                - case mul:
                    - flag <player> omp.drunkness.level:<player.flag[omp.drunkness.level].if_null[0].mul[<context.item.flag[omp.drink.strength].proc[omp_rand_range]>]>
                - case div:
                    - flag <player> omp.drunkness.level:<player.flag[omp.drunkness.level].if_null[0].div[<context.item.flag[omp.drink.strength].proc[omp_rand_range]>]>
                - case sub:
                    - flag <player> omp.drunkness.level:<player.flag[omp.drunkness.level].if_null[0].sub[<context.item.flag[omp.drink.strength].proc[omp_rand_range]>]>
                - case set:
                    - flag <player> omp.drunkness.level:<context.item.flag[omp.drink.strength].proc[omp_rand_range]>

omp_no_milk:
    type: world
    debug: false
    events:
        on player consumes milk_bucket:
            - determine passively cancelled
            - take iteminhand quantity:1
            - give bucket quantity:1 to:<player.inventory> slot:hand
