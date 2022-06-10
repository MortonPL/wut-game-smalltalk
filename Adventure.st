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
        <comment: 'Creates a game instance.'>
        | g |
        g := super new.
        g init.
        ^g
    ]

    registerInstruction: longName short: shortName code: block argc: count [
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
        self registerInstruction: #help short: #h code: [ instructionsText displayLines. ] argc: 0.
        self registerInstruction: #look short: #l code: [ self lookAround. ] argc: 0.
        self registerInstruction: #inventory short: #i code: [ self showInventory. ] argc: 0.
        self registerInstruction: #appraise short: #a code: [ :args | self appraiseItem: (args at: 1). ] argc: 1.
        self registerInstruction: #ask short: #k code: [ :args | self askAbout: (args at: 1). ] argc: 1.
        self registerInstruction: #north short: #n code: [ self movePlayer: #n. ] argc: 0.
        self registerInstruction: #east short: #e code: [ self movePlayer: #e. ] argc: 0.
        self registerInstruction: #south short: #s code: [ self movePlayer: #s. ] argc: 0.
        self registerInstruction: #west short: #w code: [ self movePlayer: #w. ] argc: 0.
        self registerInstruction: #buy short: #b code: [ :args | self buyItem: (args at: 1) quantity: (args at: 2). ] argc: 2.
        self registerInstruction: #sell short: #z code: [ :args | self sellItem: (args at: 1) quantity: (args at: 2). ] argc: 2.
        self registerInstruction: #save short: #v code: [ :args | self saveStateTo: (args at: 1). ] argc: 1.
        self registerInstruction: #load short: #d code: [ :args | self loadStateFrom: (args at: 1). ] argc: 1.
        self registerInstruction: #quit short: #q code: [ isOver := true ] argc: 0
    ]

    movePlayer: direction [
        <category: 'command'>
        <comment: 'Move player.'>
        | directionString |
        directionString := Direction asString: direction.
        (state position tryMove: (Move fromDirection: direction))
            ifTrue: [
                Array with: ('Moved ', directionString, '.') displayNl.
                self tryStorm: direction.
                self tryPirates.
                self lookAround.
            ]
            ifFalse: [ Array with: ('No money to be made up ', directionString) displayNl. ]
    ]

    showInventory [
        <category: 'command'>
        <comment: 'Display player inventory.'>
        state inventory show.
    ]

    appraiseItem: item [
        <category: 'command'>
        <comment: 'Display description of an owned item.'>
        state inventory appraise: item.
    ]

    lookAround [
        <category: 'command'>
        <comment: 'Display the current and surrounding tiles.'>
        | position |
        position := state position.
        map lookAround: position.
    ]

    buyItem: itemName quantity: anInteger [
        <category: 'command'>
        <comment: 'Buy an amount of item from a merchant.'>
        | position tile merchant unitPrice totalPrice coins |
        position := state position.
        anInteger < 1 ifTrue: [ ^'Don''t be silly' displayNl ].
        tile := map atX: (position column) atY: (position row).
        (tile isKindOf: Island) ifFalse: [ ^'There is no merchant here' displayNl ].
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
        <category: 'command'>
        <comment: 'Sell an amount of item to a merchant.'>
        | position tile merchant unitPrice totalPrice items coins |
        position := state position.
        anInteger < 1 ifTrue: [ ^'Don''t be silly' displayNl ].
        tile := map atX: (position column) atY: (position row).
        (tile isKindOf: Island) ifFalse: [ ^'There is no merchant here' displayNl ].
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
        <category: 'command'>
        <comment: 'Ask merchant about a topic.'>
        | position tile |
        position := state position.
        tile := map atX: (position column) atY: (position row).
        (tile isKindOf: Island) ifFalse: [ ^'There is nobody to ask' displayNl ].
        tile merchant ask: topic.
    ]

    saveStateTo: fileName [
        <category: 'command'>
        <comment: 'Save game state to a file.'>
        fullname := 'saves/' , fileName , '.sav'.
        (File isAccessible: 'saves') ifFalse: [Directory create: 'saves'].
        stream := FileStream open: fullname mode: FileStream write.
        state serialize: stream.
        stream close.
    ]

    loadStateFrom: fileName [
        <category: 'command'>
        <comment: 'Load game state from a file.'>
        fullname := 'saves/' , fileName , '.sav'.
        (File isReadable: fullname) ifFalse: [Exception signal: 'File doesn''t exist!'].
        stream := FileStream open: fullname mode: FileStream read.
        state deserialize: stream.
        stream close.
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
        validCommand := instructionMap at: (cmd asSymbol) ifAbsent: [ ^'Unknown command.' displayNl. ].
        argc := validCommand at: 1.
        (args size == argc)
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
