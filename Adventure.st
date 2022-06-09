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
    | isGameOver |

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
        ''
    ).

    instructionsText := #(
        'Available commands are:'
        ''
        'instructions  -- to see these instructions.'
        'quit          -- to end the game and quit.'
        ''
    ).
 
    Game class >> new [
        <category: 'instance creation'>
        | g |
        g := super new.
        g init.
        ^g
    ]

    init [
        <category: 'initialization'>
        isGameOver := false
    ]

    "Print strings from array in separate lines."
    printLines: anArray [
        anArray do: [ :string | Transcript show: string; cr ]
    ]

    printIntroduction [
        self printLines: introductionText.
    ]

    printInstructions [
        self printLines: instructionsText.
    ]

    readCommand [
        Transcript show: '> '.
        ^FileStream stdin nextLine
    ]

    "Run the game."
    run [
        | cmd isUnknown |

        self printIntroduction.
        self printInstructions.

        "Game loop."
        [isGameOver] whileFalse: [

            isUnknown := true.
            cmd := self readCommand.

            cmd = 'instructions' ifTrue: [
                self printInstructions.
                isUnknown := false
            ].

            cmd = 'quit' ifTrue: [
                isGameOver := true.
                isUnknown := false
            ].
                
            isUnknown ifTrue: [
                self printLines: #('Unknown command.' '')
            ]
        ]
    ]
]

Game new run.
