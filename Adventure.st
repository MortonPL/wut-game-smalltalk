"The germ of a text adventure game
Marcin Szlenk 2022"

"Game class

Responsibilities:
* print/read outputs/inputs
* handle game loop
* handle 'instructions' and 'halt' commands

Collaborators:
* ..."

Object subclass: Game [
    | state isOver instructionMap rng |

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

        instructionMap := Dictionary new.
        self registerInstruction: #help short: #h code: [ instructionsText displayLines. ].
        self registerInstruction: #look short: #l code: [ 'Instruction not implemented.' displayNl. ].
        self registerInstruction: #inventory short: #i code: [ self showInventory. ].
        self registerInstruction: #appraise short: #a code: [ 'Instruction not implemented.' displayNl. ].
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

    tryStorm: direction [
        <category: 'private'>
        | random |
        "TODO: Check tile"
        random := rng between: 0 and: 29.
        (random < 10)
            ifTrue: [ self doStorm: direction. ]
    ]

    dirNumMap := Dictionary from: {
        #n -> 0.
        #e -> 1.
        #s -> 2.
        #w -> 3
    }.

    numDirMap := Dictionary from: {
        0 -> #n.
        1 -> #e.
        2 -> #s.
        3 -> #w
    }.

    doStorm: direction [
        <category: 'helper'>
        | rotation offset |
        rotation := dirNumMap at: direction.
        rotation := rotation + (rng between: -1 and: 1).
        rotation := rotation \\ 4.
        offset := numDirMap at: rotation.
        (state position tryMove: (Move fromDirection: offset)) displayNl.
        'You''ve been hit by a storm!' displayNl.
    ]

    minWorth := 100.
    maxWorth := 500.
    piratesChance := 1 / 2.

    tryPirates [
        <category: 'private'>
        | worth chance random |
        worth := state inventory worth.
        chance := worth - minWorth.
        chance := chance / (maxWorth - minWorth).
        chance := chance * piratesChance.
        random := rng between: 0 and: 99.
        ((random  / 100) < chance)
            ifTrue: [ self doPirates. ]
    ]

    doPirates [
        <category: 'helper'>
        | mercenaries |
        'You''ve been attacked by pirates!' displayNl.
        mercenaries := state inventory count: 'mercenary'.
        (mercenaries > 0)
            ifTrue: [
                state inventory modify: 'mercenary' by: -1.
                'Your mercenaries defended you! (-1 mercenary)' displayNl.
                self tryGiveMapPiece1.
            ]
            ifFalse: [
                state inventory halve.
                'The''ve robbed half of your possesions!' displayNl.
            ].
    ]

    tryGiveMapPiece1 [
        <category: 'helper'>
        "TODO"
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

Game new run.
