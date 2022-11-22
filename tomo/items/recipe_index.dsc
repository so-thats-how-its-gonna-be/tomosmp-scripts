recipes_index_reload:
    type: world
    debug: true
    events:
        after script reload:

            - define craft_scripts <util.scripts.filter_tag[<[filter_value].container_type.equals[item].and[<[filter_value].data_key[recipes].exists>]>]>
            - define valid_recipes <list>

            - foreach <[craft_scripts]> as:script:
                - define recipes <[script].data_key[recipes]>
                - foreach <[recipes]> as:recipe_data key:recipe_id:
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
                        - define "book_pages:->:<[page_title]><n><&b>Stonecutting Recipe<n><&7>Input: <[recipe.input].proc[item_name]><&7><n>"
                    - case smithing:
                        - define "book_pages:->:<[page_title]><n><&b>Smithing Recipe<n><&7>Left Side: <[recipe.base].proc[item_name]><&7><n>Right Side: <[recipe.upgrade].proc[item_name]><&7><n>"
                    - case furnace:
                        - define "book_pages:->:<[page_title]><n><&b>Furnace Recipe<n><&7>Input: <[recipe.input].proc[item_name]><&7><n>"
                    - case blast:
                        - define "book_pages:->:<[page_title]><n><&b>Blast Furnace Recipe<n><&7>Input: <[recipe.input].proc[item_name]><&7><n>"
                    - case smoker:
                        - define "book_pages:->:<[page_title]><n><&b>Smoker Recipe<n><&7>Input: <[recipe.input].proc[item_name]><&7><n>"
                    - case campfire:
                        - define "book_pages:->:<[page_title]><n><&b>Campfire Recipe<n><&7>Input: <[recipe.input].proc[item_name]><&7><n>"
                    - case shapeless:
                        - define "book_pages:->:<[page_title]><n><&b>Shapeless Recipe<n><&7>Input: <n><[recipe.input].parse_tag[<[parse_value].proc[item_name]>].separated_by[<n>]>"

            - flag server recipes_index.book_pages:<[book_pages]>

recipes_index_open:
    type: task
    debug: false
    script:
        - definemap book:
            pages: <server.flag[recipes_index.book_pages]>
            title: Recipes Index
            author: funky493
        - define written_book <item[written_book].with_single[book=<[book]>]>
        - adjust <player> show_book:<[written_book]>

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
