Game extend [
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
]
