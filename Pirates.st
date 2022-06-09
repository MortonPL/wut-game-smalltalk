Game extend [
    minWorth := 500.
    maxWorth := 7500.
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
                'Your brave mercenaries have protected you.' displayNl.
                '(-1 mercenary)' displayNl.
                self tryGiveMapPiece1.
            ]
            ifFalse: [
                state inventory halve.
                'The''ve robbed half of your possesions!' displayNl.
                'Try hiring some guards next time!' displayNl.
            ].
    ]

    tryGiveMapPiece1 [
        <category: 'helper'>
        | mapCount |
        mapCount := state inventory count: 'map_piece_1'.
        (mapCount == 0)
            ifTrue: [
                state inventory modify: 'map_piece_1' by: 1.
                'You''ve found a map piece in the wreckage!' displayNl.
            ].
    ]
]

Inventory extend [
    itemWorth := Dictionary from: {
        'rum' -> 50.
        'gunpowder' -> 30.
        'blunderbuss' -> 30.
        'ration' -> 10.
        'banana' -> 10.
        'map_piece_1' -> 5000.
        'map_piece_2' -> 5000.
        'mercenary' -> -1000.
        'coin' -> 1
    }.

    worth [
        <category: 'helper'>
        | totalWorth |
        totalWorth := 0.
        content keysAndValuesDo: [ :key :value |
            totalWorth := totalWorth + (value * (itemWorth at: key ifAbsent: [ 0 ])).
        ].
        ^totalWorth
    ]
]
