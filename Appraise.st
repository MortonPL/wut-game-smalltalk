Inventory extend [
    descriptions := Dictionary from: {
        'balls' -> 'round n'' all'.
        'cubes' -> 'square n'' all'.
        'smetana' -> 'ლ(´ڡ`ლ)'.
        'mercenary' -> 'your daddy taught you well'
    }.

    appraise: item [
        <category: 'printer'>
        | count description |
        count := content at: item ifAbsent: [ 0 ].
        (count > 0)
            ifTrue: [
                descriptions at: item ifPresent: [ :desc | 
                    desc displayNl.
                ].
            ]
            ifFalse: [
                'You don''t own such item.' displayNl.
            ].
    ]
]
