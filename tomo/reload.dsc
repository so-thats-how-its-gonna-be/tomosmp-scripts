auto_actions:
    type: world
    debug: false
    events:
        after delta time secondly every:30:
            - reload
        after delta time minutely every:5:
            - adjust server save
