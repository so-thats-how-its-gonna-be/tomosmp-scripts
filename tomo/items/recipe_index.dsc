recipes_index_reload:
    type: world
    debug: true
    events:
        after script reload:

            - define craft_scripts <util.scripts.filter_tag[<[filter_value].container_type.equals[item].and[<[filter_value].data_key[recipes].exists>]>]>
            - define valid_recipes <list>

            - foreach <[craft_scripts]> as:script:
                - define recipes <[script].data_key[recipes]>
                - foreach <[recipes]> as:recipe_id key:recipe_data:
                    - define add_recipe <[recipe_data].with[output].as[<item[<[script].original_name>]>]>
                    - define add_recipe.output_quantity:1 if:<[add_recipe].get[output_quantity].exists.not>
                    - define valid_recipes:->:<[add_recipe]>

            - flag server recipes_index.recipes:<[valid_recipes]>

            - define book_pages <list>
            - foreach <server.flag[recipes_index.recipes]> as:recipe:
                - define item_name <[recipe.output].proc[item_name]>
                - define page_title <[item_name]>
                - choose <[recipe.type]>:
                    - default:
                        - foreach next
                    - case stonecutting:
                        - define "book_pages:->:<[page_title]><n><&7>Stonecutting Recipe<n><&f>Input: <[recipe.input].proc[item_name]><&f><n>"
                    - case smithing:
                        - define "book_pages:->:<[page_title]><n><&7>Smithing Recipe<n><&f>Left Side: <[recipe.base].proc[item_name]><&f><n>Right Side: <[recipe.upgrade].proc[item_name]><&f><n>"
                    - case furnace:
                        - define "book_pages:->:<[page_title]><n><&7>Furnace Recipe<n><&f>Input: <[recipe.input].proc[item_name]><&f><n>"
                    - case blast:
                        - define "book_pages:->:<[page_title]><n><&7>Blast Furnace Recipe<n><&f>Input: <[recipe.input].proc[item_name]><&f><n>"
                    - case smoker:
                        - define "book_pages:->:<[page_title]><n><&7>Smoker Recipe<n><&f>Input: <[recipe.input].proc[item_name]><&f><n>"
                    - case campfire:
                        - define "book_pages:->:<[page_title]><n><&7>Campfire Recipe<n><&f>Input: <[recipe.input].proc[item_name]><&f><n>"
                    - case shapeless:
                        - define "book_pages:->:<[page_title]><n><&7>Shapeless Recipe<n><&f>Input: <n><[recipe.input].parse_tag[<[parse_value].proc[item_name]>].separated_by[<n>]>"

            - flag server recipes_index.book_pages:<[book_pages]>

recipes_index_open:
    type: task
    debug: false
    script:
        - adjust <player> show_book:<item[written_book].with_single[book=<map[pages=<server.flag[recipes_index.book_pages]>]>]>

recipes_index_dummy:
    type: item
    material: book
    display name: Recipes Index
    enchantments:
        - unbreaking:1
    mechanisms:
        hides: all
    recipes:
        1:
            type: smithing
            base: book
            upgrade: crafting_table

recipes_index_dummy_open:
    type: world
    debug: false
    events:
        on player right clicks block with:recipes_index_dummy:
            - run recipes_index_open
