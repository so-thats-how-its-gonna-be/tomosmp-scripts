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

                - if <player.has_flag[omp.drunkness].not>:
                    - flag <player> omp.drunkness.level:0

                - define drunkness <player.flag[omp.drunkness.level]>

                - if <util.random_chance[30]> && <[drunkness]> > 0:
                    - flag <player> omp.drunkness.level:<[drunkness].sub[<util.random.decimal[0].to[0.1]>].max[0]>

                - foreach next if:<[drunkness].is_less_than[<[omp_data.global_tolerance]>]>

                - if <util.random_chance[<[drunkness].sub[1].mul[3]>]>:
                    - define effect <[omp_data.effects].keys.random>
                    - define duration <duration[<[omp_data.effects.<[effect]>.duration]>]>
                    - define amplifier <[omp_data.effects.<[effect]>.amplifier].proc[omp_rand_range].round.sub[1]>
                    - cast <[effect]> <player> amplifier:<[amplifier]> duration:<[duration]> if:<player.has_effect[<[effect]>].not>

                - if <[drunkness]> > 10 && <util.random_chance[<[drunkness].sub[9].mul[3]>]>:
                    - hurt <player> 1 cause:MAGIC source:<player>
                    - playsound <player> sound:entity_warden_heartbeat sound_category:PLAYERS pitch:2 volume:2

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
