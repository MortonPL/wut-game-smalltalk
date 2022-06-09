Object subclass: Position [
    | column row |
 
    Position class >> x: horizontal y: vertical [
        <category: 'instance creation'>
        | r |
        (horizontal isInteger) ifFalse: [ ^self error: 'Invalid argument for message x: must be an integer' ].
        (vertical isInteger) ifFalse: [ ^self error: 'Invalid argument for message y: must be an integer' ].
        r := super new.
        r setX: horizontal setY: vertical.
        ^r
    ]

    setX: x setY: y [
        (x isInteger) ifFalse: [ ^self error: 'Invalid argument for message setX: must be an integer' ].
        (y isInteger) ifFalse: [ ^self error: 'Invalid argument for message setY: must be an integer' ].
        column := x.
        row := y.
        ^self
    ]

    + move [
        (move isMemberOf: Move) ifFalse: [ ^self error: 'Invalid argument for message +: must be a Move instance' ].
        column := column + (move x).
        row := row + (move y).
        ^self
    ]
]
