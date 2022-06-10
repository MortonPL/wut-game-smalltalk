"Game class

Responsibilities:
* read inputs
* run game loop
* handle commands"

Object subclass: Game [
    | state isOver instructionMap rng map |

    introductionText := #(
        '+=======================================+'
        '|         ''AHOY'' IS FIVE DOLLARS        |'
        '|     A text adventure trading game.    |'
        '+=======================================+'
        ''
        '              |    |    |  '
        '             )_)  )_)  )_)'
        '            )___))___))___)'
        '           )____)____)_____)'
        '         _____|____|____|________'
        '~~~~~~~~~\\ lvl 3 cockswain \\   /~~~~~~~~~'
        '  ^^~^^ ^^^~~~~^^^^^~~^^^^^^^    ^^~~^~'
        '    ^^^  ~~   ^^^^     ^^~    ~~~~'
        ' ~~      ~~^^      ^~^     ~~         ^~^'
        ''
        '        by B.Moroz,J.Motyka,D.Sygocki, 2022'
    ).

    instructionsText := #(
        'Available commands are:'
        ''
        'h/help                 -- to see this list.'
        'l/look                 -- to look around.'
        'i/inventory            -- to check inventory.'
        'a/appraise <name>      -- to appraise items.'
        'n/north                -- to go north.'
        'e/east                 -- to go east.'
        's/south                -- to go south.'
        'w/west                 -- to go west.'
        'b/buy <name> <amount>  -- to buy items.'
        'b/buy <name>           -- to buy an item.'
        's/sell <name> <amount> -- to sell items.'
        's/sell <name>          -- to sell an item.'
        'k/ask                  -- to list available topics.'
        'k/ask <topic>          -- to ask questions.'
        'v/save <file>          -- to save the game.'
        'd/load <file>          -- to load the game.'
        'q/quit                 -- to end the game and quit.'
    ).

    Game class >> new [
        <category: 'instance creation'>
        <comment: 'Creates a game instance.'>
        ^(super new) init; yourself
    ]

    registerInstruction: longName short: shortName argc: count code: block [
        <category: 'helper'>
        <comment: 'Registers a command handler.'>
        | value |
        value := {count. block}.
        instructionMap at: shortName put: value.
        instructionMap at: longName put: value.
    ]

    init [
        <category: 'initialization'>
        <comment: 'Initializes the game class.'>
        isOver := false.
        state := GameState new.
        rng := Random new.
        map := Map new.

        instructionMap := Dictionary new.
        self registerInstruction: 'help'      short: 'h' argc: 0 code: [ instructionsText displayLines. ].
        self registerInstruction: 'look'      short: 'l' argc: 0 code: [ self lookAround. ].
        self registerInstruction: 'inventory' short: 'i' argc: 0 code: [ self showInventory. ].
        self registerInstruction: 'appraise'  short: 'a' argc: 1 code: [ :args | self appraiseItem: (args at: 1). ].
        self registerInstruction: 'north'     short: 'n' argc: 0 code: [ self movePlayer: 'n'. ].
        self registerInstruction: 'east'      short: 'e' argc: 0 code: [ self movePlayer: 'e'. ].
        self registerInstruction: 'south'     short: 's' argc: 0 code: [ self movePlayer: 's'. ].
        self registerInstruction: 'west'      short: 'w' argc: 0 code: [ self movePlayer: 'w'. ].
        self registerInstruction: 'buy'       short: 'b' argc: 1 code: [ :args |
            self buyItem: (args at: 1) quantity: (args size > 1 ifTrue: [ (args at: 2) asInteger ] ifFalse: [ 1 ]). ].
        self registerInstruction: 'sell'      short: 'z' argc: 1 code: [ :args |
            self sellItem: (args at: 1) quantity: (args size > 1 ifTrue: [ (args at: 2) asInteger ] ifFalse: [ 1 ]). ].
        self registerInstruction: 'ask'       short: 'k' argc: 0 code: [ :args |
            self askAbout: (args size > 0 ifTrue: [ args at: 1 ] ifFalse: [ 'topics' ]). ].
        self registerInstruction: 'save'      short: 'v' argc: 1 code: [ :args | self saveStateTo: (args at: 1). ].
        self registerInstruction: 'load'      short: 'd' argc: 1 code: [ :args | self loadStateFrom: (args at: 1). ].
        self registerInstruction: 'quit'      short: 'q' argc: 0 code: [ isOver := true ]
    ]

    readCommand [
        <category: 'helper'>
        <comment: 'Prompts user for a single command.'>
        Transcript nl; show: '> '.
        ^FileStream stdin nextLine
    ]

    getState [
        <category: 'accessor'>
        <comment: 'Returns the game state.'>
        ^state
    ]

    command: cmd with: args [
        <category: 'helper'>
        <comment: 'Runs a single command.'>
        | validCommand action argc |
        validCommand := instructionMap at: cmd ifAbsent: [ ^'Unknown command.' displayNl. ].
        argc := validCommand at: 1.
        (args size >= argc)
            ifFalse: [ ^'Invalid amount of arguments.' displayNl. ].
        action := validCommand at: 2.
        action cull: args.
    ]

    run [
        <category: 'main'>
        <comment: 'App entry point.'>
        | cmd isUnknown tokens |
        introductionText displayLines.
        instructionsText displayLines.

        [ isOver ] whileFalse: [
            tokens := self readCommand tokenize: ' '.
            (tokens size > 0)
                ifTrue: [ self command: (tokens at: 1) with: (tokens allButFirst). ].
        ]
    ]
]
