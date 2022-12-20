# Takes an element such as "1-5" and returns a random number between 1 and 5. If the element is not a range, it will return the element itself.
omp_rand_range:
    type: procedure
    debug: false
    definitions: element
    script:
        - if <[element].contains[-]>:
            - determine <util.random.decimal[<[element].split[-].get[1]>].to[<[element].split[-].get[2]>]>
        - else:
            - determine <[element]>
