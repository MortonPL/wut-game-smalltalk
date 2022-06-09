Game extend [
    tryStorm: direction [
        <category: 'private'>
        <comment: 'Attempts to perform the storm event.'>
        | position tile random |
        position := state position.
        tile := map atX: (position column) atY: (position row).
        (tile isKindOf: DeepWater)
            ifTrue: [
                random := rng between: 0 and: 29.
                (random < 10)
                    ifTrue: [ self doStorm: direction. ]
            ]
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
        <comment: 'Performs the storm event.'>
        | rotation offset |
        rotation := dirNumMap at: direction.
        rotation := rotation + (rng between: -1 and: 1).
        rotation := rotation \\ 4.
        offset := numDirMap at: rotation.
        state position tryMove: (Move fromDirection: offset).
        'You''ve been hit by a storm!' displayNl.
    ]
]
