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
        | g |
        g := super new.
        g init.
        ^g
    ]

    init [
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
        ^ FileStream stdin nextLine
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

"serialization PoC"

Object subclass: Serializable [
    | value |

    Serializable class >> new [
        | obj |
        obj := super new.
        obj init.
        ^obj
    ]

    init [
        value := 0
    ]

    getValue [ ^value ]
    setValue: v [ value := v ]

    "przykładowe serdle"
    serialize: stream [ stream nextPutAll: (value printString); nextPut: $| ]
    deserialize: stream [ value := (stream upTo: $|) asNumber. "asBoolean, asFloat" ]
]

b1 := Serializable new.
b2 := Serializable new.

b1 setValue: 3.
b2 setValue: 4.

filename := 'test'.
fullname := 'saves/' , filename , '.sav'.

(File isAccessible: 'saves') ifFalse: [Directory create: 'saves'].
stream := FileStream open: fullname mode: FileStream write.
b1 serialize: stream.
b2 serialize: stream.
stream close.

b1 setValue: 1.
b2 setValue: 2.

(File isReadable: fullname) ifFalse: [Exception signal: 'File doesn''t exist!'].
stream := FileStream open: fullname mode: FileStream read.
b1 deserialize: stream.
b2 deserialize: stream.
stream close.

b1 getValue printNl.
b2 getValue printNl.
