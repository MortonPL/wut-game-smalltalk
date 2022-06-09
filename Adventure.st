"Game class

Responsibilities:
* print/read outputs/inputs
* handle game loop
* handle 'instructions' and 'halt' commands

Collaborators:
* ..."

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
        '        by Hocki Klocki Sygocki, 2022'
    ).

    instructionsText := #(
        'Available commands are:'
        ''
        'instructions  -- to see these instructions.'
        'h/help        -- to see this list.'
        'l/look        -- to look around.'
        'i/inventory   -- to check inventory.'
        'a/appraise    -- to appraise items.'
        'n/north       -- to go north.'
        'e/east        -- to go east.'
        's/south       -- to go south.'
        'w/west        -- to go west.'
        'b/buy         -- to buy items.'
        's/sell        -- to sell items.'
        'k/ask         -- to ask questions.'
        'v/save <file> -- to save the game.'
        'd/load <file> -- to load the game.'
        'q/quit        -- to end the game and quit.'
    ).

    Game class >> new [
        <category: 'instance creation'>
        | g |
        g := super new.
        g init.
        ^g
    ]

    registerInstruction: longName short: shortName code: block [
        <category: 'private'>
        instructionMap at: shortName put: (instructionMap at: longName put: block)
    ]

    init [
        <category: 'initialization'>
        isOver := false.
        state := GameState new.
        rng := Random new.
        map := Map new.

        instructionMap := Dictionary new.
        self registerInstruction: #help short: #h code: [ instructionsText displayLines. ].
        self registerInstruction: #look short: #l code: [ 'Instruction not implemented.' displayNl. ].
        self registerInstruction: #inventory short: #i code: [ self showInventory. ].
        self registerInstruction: #appraise short: #a code: [ self appraiseItem: 'balls'. ].
        self registerInstruction: #north short: #n code: [ self movePlayer: #n. ].
        self registerInstruction: #east short: #e code: [ self movePlayer: #e. ].
        self registerInstruction: #south short: #s code: [ self movePlayer: #s. ].
        self registerInstruction: #west short: #w code: [ self movePlayer: #w. ].
        self registerInstruction: #buy short: #b code: [ 'Instruction not implemented.' displayNl. ].
        self registerInstruction: #sell short: #z code: [ 'Instruction not implemented.' displayNl. ].
        self registerInstruction: #ask short: #k code: [ 'Instruction not implemented.' displayNl. ].
        self registerInstruction: #save short: #v code: [ 'Instruction not implemented.' displayNl. ].
        self registerInstruction: #load short: #d code: [ 'Instruction not implemented.' displayNl. ].
        self registerInstruction: #quit short: #q code: [ isOver := true ]
    ]

    movePlayer: direction [
        <category: 'private'>
        | directionString |
        directionString := Direction asString: direction.
        (state position tryMove: (Move fromDirection: direction))
            ifTrue: [
                self tryStorm: direction.
                self tryPirates.
                Array with: ('  - Moved ', directionString) displayNl.
            ]
            ifFalse: [ Array with: ('  - No money to be made up ', directionString) displayNl. ]
    ]

    showInventory [
        <category: 'private'>
        state inventory show.
    ]

    appraiseItem: item [
        <category: 'private'>
        state inventory appraise: item.
    ]

    readCommand [
        Transcript nl; show: '> '.
        ^FileStream stdin nextLine
    ]

    "Run the game."
    run [
        | cmd isUnknown action |
        introductionText displayLines.
        instructionsText displayLines.

        "Game loop."
        [ isOver ] whileFalse: [
            isUnknown := true.
            cmd := self readCommand.
            action := instructionMap at: (cmd asSymbol) ifAbsent: [ [ 'Unknown command.' displayNl. ] ].
            action value
        ]
    ]
]
