Object subclass: Move [
    | xMove yMove |

    Move class >> new [
        <category: 'instance creation'>
        ^Move x: 0 y: 0
    ]
 
    Move class >> x: horizontal y: vertical [
        <category: 'instance creation'>
        | r |
        horizontal isInteger ifFalse: [ ^self error: 'Invalid argument for message x: must be an integer' ].
        vertical isInteger ifFalse: [ ^self error: 'Invalid argument for message y: must be an integer' ].
        r := super new.
        r setX: horizontal setY: vertical.
        ^r
    ]
 
    Move class >> fromDirection: direction [
        <category: 'instance creation'>
        | r initialized |
        r := super new.
        initialized := false.
        ^(Dictionary from: {
            #n -> (Move x: 0 y: -1).
            #e -> (Move x: 1 y: 0).
            #w -> (Move x: -1 y: 0).
            #s -> (Move x: 0 y: 1)
        }) at: direction ifAbsent: [ ^self error: 'Incorrect argument for message fromDirection: must be one of #n, #e, #w, #s' ]
    ]

    setX: x setY: y [
        x isInteger ifFalse: [ ^self error: 'Invalid argument for message x: must be an integer' ].
        y isInteger ifFalse: [ ^self error: 'Invalid argument for message y: must be an integer' ].
        xMove := x.
        yMove := y.
    ]

    x [
        <category: 'accessor'>
        ^xMove
    ]

    y [
        <category: 'accessor'>
        ^yMove
    ]
]
