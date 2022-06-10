Inventory extend [
    descriptions := Dictionary from: {
        'rum'         -> 'Would be delicious with Cola, if I knew what that was.'.
        'gunpowder'   -> 'Let''s hope it doesn''t explode.'.
        'blunderbuss' -> 'I like to call it the Blunderbussy.'.
        'ration'      -> 'Meat so dry you can rip pants with it.'.
        'banana'      -> 'A source of comedy. Especially when rotated.'.
        'map_piece_1' -> 'A map piece that appears to be torn in half. Maybe I can find the other piece if I ask merchants?'.
        'map_piece_2' -> 'A map piece that appears to be torn in half. Maybe the pirates know something about the other piece?'.
        'mercenary'   -> 'The power of Sun Tzu in the palm of your hand. Reduces pirate attacks and deflects them.'.
        'coin'        -> 'Local currency. I think it''s named ''Kromer''?'
    }.

    missingItemMessage := {
        [ :item | 'You don''t own such item.' ].
        [ :item | 'There is nothing to appraise.' ].
        [ :item | 'There is no `', item, '` in your pocket.' ].
        [ :item | 'You don''t own `', item, '`, whetever it may be.' ]
    }.

    missingItem: item [
        <category: 'printer'>
        <comment: 'Displays one of the ''missing item'' messages during failed appraisal.'>
        | rng random |
        rng := Random new.
        random := rng between: 1 and: 4.
        ((missingItemMessage at: random) value: item) displayNl.
    ]

    appraise: item [
        <category: 'printer'>
        <comment: 'Displays messages for item appraisal.'>
        | count description |
        count := content at: item ifAbsent: [ 0 ].
        (count > 0)
            ifTrue: [
                descriptions at: item ifPresent: [ :desc | 
                    desc displayNl.
                ].
            ]
            ifFalse: [ self missingItem: item. ].
    ]
]
