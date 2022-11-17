block_drop_fixer:
    type: world
    events:
        on player breaks block:
            - stop if:<player.gamemode.equals[CREATIVE]>
            - stop if:<context.should_drop_items.not>
            - stop if:<server.flag[tomo.features.block_drop_fixer].not>
            - if <script[block_drop_fixer_data].data_key[conversions].keys.contains[<context.material.name>]>:
                - determine <script[block_drop_fixer_data].data_key[conversions].get[<context.material.name>].as[item]>

block_drop_fixer_data:
    type: data
    conversions:
        stone_slab: cobblestone
