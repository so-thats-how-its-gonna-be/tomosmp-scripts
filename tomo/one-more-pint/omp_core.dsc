omp_data:
    type: data
    omp:
        global_tolerance: 2
        effects:
            blindness:
                duration: 5s-30s
                amplifier: 0-2
            confusion:
                duration: 5s-15s
                amplifier: 0
            hunger:
                duration: 5s-1m
                amplifier: 0-2

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
                    - define amplifier <[omp_data.effects.<[effect]>.amplifier].proc[omp_rand_range]>
                    - cast <[effect]> <player> amplifier:<[amplifier]> duration:<[duration]>

omp_rand_range:
    type: procedure
    debug: false
    definitions: element
    script:
        - if <[element].contains[-]>:
            - determine <util.random.int[<[element].split[-].get[1]>].to[<[element].split[-].get[2]>]>
        - else:
            - determine <[element]>
