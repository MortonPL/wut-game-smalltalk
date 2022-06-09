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
    | isGameOver instructionMap |

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
        '~~~~~~~~~\\ lvl 2 scallywag \\   /~~~~~~~~~'
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
        isGameOver := false.

        instructionMap := Dictionary new.
        self registerInstruction: #help short: #h code: [ instructionsText printLines ].
        self registerInstruction: #look short: #l code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #inventory short: #i code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #appraise short: #a code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #north short: #n code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #east short: #e code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #south short: #s code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #west short: #w code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #buy short: #b code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #sell short: #z code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #ask short: #k code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #save short: #v code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #load short: #d code: [ #('Instruction not implemented.') printLines ].
        self registerInstruction: #quit short: #q code: [ isGameOver := true ]
    ]

    readCommand [
        Transcript nl; show: '> '.
        ^FileStream stdin nextLine
    ]

    "Run the game."
    run [
        | cmd isUnknown action |
        introductionText printLines.
        instructionsText printLines.

        "Game loop."
        [isGameOver] whileFalse: [
            isUnknown := true.
            cmd := self readCommand.
            action := instructionMap at: (cmd asSymbol) ifAbsent: [ [ #('Unknown command.') printLines ] ].
            action value.
        ]
    ]
]

Game new run.
