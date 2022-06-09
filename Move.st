Object subclass: Move [
    | xMove yMove |
 
    Move class >> x: horizontal y: vertical [
        <category: 'instance creation'>
        | r |
        (horizontal isInteger) ifFalse: [ ^self error: 'Invalid argument for message x: must be an integer' ].
        (vertical isInteger) ifFalse: [ ^self error: 'Invalid argument for message y: must be an integer' ].
        r := super new.
        r setX: horizontal setY: vertical.
        ^r
    ]
 
    Move class >> fromDirection: direction [
        <category: 'instance creation'>
        | r initialized |
        r := super new.
        initialized := false.
        #(
            (#n #(0 -1))
            (#e #(1 0))
            (#w #(-1 0))
            (#s #(0 1))
        ) do: [ :each |
            ((each at: 1) = direction) ifTrue: [
                r setX: ((each at: 2) at: 1) setY: ((each at: 2) at: 2).
                initialized := true
            ]
        ].
        (initialized = false) ifTrue: [ ^self error: 'Incorrect argument for message fromDirection: must be one of #n, #e, #w, #s' ].
        ^r
    ]

    setX: x setY: y [
        (x isInteger) ifFalse: [ ^self error: 'Invalid argument for message x: must be an integer' ].
        (y isInteger) ifFalse: [ ^self error: 'Invalid argument for message y: must be an integer' ].
        xMove := x.
        yMove := y.
        ^self
    ]

    x [
        <category: 'basic'>
        ^xMove
    ]

    y [
        <category: 'basic'>
        ^yMove
    ]
]
