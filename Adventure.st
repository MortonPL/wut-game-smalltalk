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
        '        by B.Moroz,J.Motyka,D.Sygocki, 2022'
    ).

    instructionsText := #(
        'Available commands are:'
        ''
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
        self registerInstruction: #look short: #l code: [ self lookAround. ].
        self registerInstruction: #inventory short: #i code: [ self showInventory. ].
        self registerInstruction: #appraise short: #a code: [ :args | self appraiseItem: (args at: 1). ].
        self registerInstruction: #north short: #n code: [ self movePlayer: #n. ].
        self registerInstruction: #east short: #e code: [ self movePlayer: #e. ].
        self registerInstruction: #south short: #s code: [ self movePlayer: #s. ].
        self registerInstruction: #west short: #w code: [ self movePlayer: #w. ].
        self registerInstruction: #buy short: #b code: [ :args | self buyItem: (args at: 1) quantity: (args at: 2). ].
        self registerInstruction: #sell short: #z code: [ :args | self sellItem: (args at: 1) quantity: (args at: 2). ].
        self registerInstruction: #ask short: #k code: [ :args | self askAbout: (args at: 1). ].
        self registerInstruction: #save short: #v code: [ :args | self saveStateTo: (args at: 1). ].
        self registerInstruction: #load short: #d code: [ :args | self loadStateFrom: (args at: 1). ].
        self registerInstruction: #quit short: #q code: [ isOver := true ]
    ]

    movePlayer: direction [
        <category: 'private'>
        | directionString |
        directionString := Direction asString: direction.
        (state position tryMove: (Move fromDirection: direction))
            ifTrue: [
                Array with: ('Moved ', directionString) displayNl.
                self tryStorm: direction.
                self tryPirates.
                self lookAround.
            ]
            ifFalse: [ Array with: ('No money to be made up ', directionString) displayNl. ]
    ]

    showInventory [
        <category: 'private'>
        state inventory show.
    ]

    appraiseItem: item [
        <category: 'private'>
        state inventory appraise: item.
    ]

    lookAround [
        <category: 'private'>
        | position |
        position := state position.
        map lookAround: position.
    ]

    buyItem: itemName quantity: anInteger [
        <category: 'private'>
        | position tile merchant unitPrice totalPrice coins |
        position := state position.
        anInteger < 1 ifTrue: [ ^'Don''t be silly' displayNl ].
        tile := map atX: (position column) atY: (position row).
        tile isLand ifFalse: [ ^'There is no merchant here' displayNl ].
        merchant := tile merchant.
        merchant sells: itemName ifFalse: [ ^(merchant name, ' has no ', itemName, ' in stock') displayNl ].
        unitPrice := merchant offer sellingPriceForSingle: itemName.
        totalPrice := anInteger * unitPrice.
        coins := state inventory count: 'coin'.
        coins < totalPrice ifTrue: [ ^'Come back when you''re a little richer.' displayNl ].
        state inventory modify: 'coin' by: totalPrice negated.
        state inventory modify: itemName by: anInteger.
        ('You bought ', anInteger, ' of ', itemName, ' from ', merchant name , ' for ', totalPrice, ' coins.') displayNl.
    ]

    sellItem: itemName quantity: anInteger [
        <category: 'private'>
        | position tile merchant unitPrice totalPrice items |
        position := state position.
        anInteger < 1 ifTrue: [ ^'Don''t be silly' displayNl ].
        tile := map atX: (position column) atY: (position row).
        tile isLand ifFalse: [ ^'There is no merchant here' displayNl ].
        merchant := tile merchant.
        merchant buys: itemName ifFalse: [ ^(merchant name, ' doesn''t want your ', itemName) displayNl ].
        items := state inventory count: itemName.
        items < anInteger ifTrue: [ ^('There is not enough ', itemName, ' on you.') displayNl ].
        unitPrice := merchant offer buyingPriceForSingle: itemName.
        totalPrice := anInteger * unitPrice.
        coins := state inventory count: 'coin'.
        state inventory modify: itemName by: anInteger negated.
        state inventory modify: 'coin' by: totalPrice.
        ('You sold ', anInteger, ' of ', itemName, ' to ', merchant name , ' for ', totalPrice, ' coins.') displayNl.
    ]

    askAbout: topic [
        <category: 'private'>
        | position tile |
        position := state position.
        tile := map atX: (position column) atY: (position row).
        tile isLand ifFalse: [ ^'There is nobody to ask' displayNl ].
        tile merchant ask: topic.
    ]

    saveStateTo: fileName [
        <category: 'private'>
    ]

    loadStateFrom: fileName [
        <category: 'private'>
    ]

    readCommand [
        Transcript nl; show: '> '.
        ^FileStream stdin nextLine
    ]

    getState [
        ^state
    ]

    "Run the game."
    run [
        | cmd isUnknown action |
        introductionText displayLines.
        instructionsText displayLines.

        "Game loop."
        [ isOver ] whileFalse: [
            isUnknown := true.
            cmd := self readCommand tokenize: ' '.
            action := instructionMap at: ((cmd at: 1) asSymbol) ifAbsent: [ [ 'Unknown command.' displayNl. ] ].
            action cull: cmd allButFirst
        ]
    ]
]
