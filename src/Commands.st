Game extend [
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
        "quantity check"
        anInteger < 1 ifTrue: [ ^'Don''t be silly' displayNl ].
        "position check"
        position := state position.
        tile := map atX: (position column) atY: (position row).
        (tile isKindOf: Island) ifFalse: [ ^'There is no merchant here' displayNl ].
        "merchant offer check"
        merchant := tile merchant.
        (merchant sells: itemName) ifFalse: [ ^(merchant name, ' has no ', itemName, ' in stock') displayNl ].
        "inventory state check"
        unitPrice := merchant offer sellingPriceForSingle: itemName.
        totalPrice := anInteger * unitPrice.
        coins := state inventory count: 'coin'.
        coins < totalPrice ifTrue: [ ^'Come back when you''re a little richer.' displayNl ].
        "transaction"
        state inventory modify: 'coin' by: totalPrice negated.
        state inventory modify: itemName by: anInteger.
        ('You bought ', anInteger printString, ' of ', itemName, ' from ', merchant name,
            ' for ', totalPrice printString, ' coins.') displayNl.
    ]

    sellItem: itemName quantity: anInteger [
        <category: 'command'>
        <comment: 'Sell an amount of item to a merchant.'>
        | position tile merchant unitPrice totalPrice items coins |
        "quantity check"
        anInteger < 1 ifTrue: [ ^'Don''t be silly' displayNl ].
        "position check"
        position := state position.
        tile := map atX: (position column) atY: (position row).
        (tile isKindOf: Island) ifFalse: [ ^'There is no merchant here' displayNl ].
        "merchant offer check"
        merchant := tile merchant.
        (merchant buys: itemName) ifFalse: [ ^(merchant name, ' doesn''t want your ', itemName) displayNl ].
        "inventory state check"
        items := state inventory count: itemName.
        items < anInteger ifTrue: [ ^('There is not enough ', itemName, ' on you.') displayNl ].
        "transaction"
        unitPrice := merchant offer buyingPriceForSingle: itemName.
        totalPrice := anInteger * unitPrice.
        state inventory modify: itemName by: anInteger negated.
        state inventory modify: 'coin' by: totalPrice.
        ('You sold ', anInteger printString, ' of ', itemName, ' to ', merchant name,
            ' for ', totalPrice printString, ' coins.') displayNl.
    ]

    askAbout: topic [
        <category: 'command'>
        <comment: 'Ask merchant about a topic.'>
        | position tile |
        position := state position.
        tile := map atX: (position column) atY: (position row).
        (tile isKindOf: Island) ifFalse: [ ^'There is nobody to ask' displayNl ].
        tile merchant answer: topic.
    ]

    saveStateTo: fileName [
        <category: 'command'>
        <comment: 'Save game state to a file.'>
        | fullname stream |
        fullname := 'saves/', fileName, '.sav'.
        (File isAccessible: 'saves') ifFalse: [Directory create: 'saves'].
        stream := FileStream open: fullname mode: FileStream write.
        state serialize: stream.
        stream close.
        ('Saved to: ', fullname) displayNl
    ]

    loadStateFrom: fileName [
        <category: 'command'>
        <comment: 'Load game state from a file.'>
        | fullname stream |
        fullname := 'saves/', fileName, '.sav'.
        (File isReadable: fullname) ifFalse: [Exception signal: 'File doesn''t exist!'].
        stream := FileStream open: fullname mode: FileStream read.
        state deserialize: stream.
        stream close.
        ('Loaded from: ', fullname) displayNl
    ]
]
