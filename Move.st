Object subclass: Move [
    | xMove yMove |

    Move class >> new [
        <category: 'instance creation'>
        <comment: 'Creates a move instance.'>
        ^Move x: 0 y: 0
    ]

    setX: x setY: y [
        <category: 'initialization'>
        <comment: 'Initializes the move instance with coordinates.'>
        x isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: x mustBe: Integer ].
        y isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: y mustBe: Integer ].
        xMove := x.
        yMove := y.
    ]
 
    Move class >> x: horizontal y: vertical [
        <category: 'instance creation'>
        <comment: 'Creates a move instance from coordinates.'>
        | r |
        horizontal isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: horizontal mustBe: Integer ].
        vertical isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: vertical mustBe: Integer ].
        r := super new.
        r setX: horizontal setY: vertical.
        ^r
    ]

    dirMoveMap := Dictionary from: {
        'n' -> [ Move x: 0 y: -1 ].
        'e' -> [ Move x: 1 y: 0 ].
        'w' -> [ Move x: -1 y: 0 ].
        's' -> [ Move x: 0 y: 1 ]
    }.
 
    Move class >> fromDirection: direction [
        <category: 'instance creation'>
        <comment: 'Creates a move instance from direction.'>
        | r initialized |
        r := super new.
        initialized := false.
        ^(dirMoveMap at: direction
            ifAbsent: [ ^self error: 'Incorrect argument for message fromDirection: must be one of ''n'', ''e'', ''w'', ''s''' ])
            value
    ]

    x [
        <category: 'accessor'>
        <comment: 'Returns the x component.'>
        ^xMove
    ]

    y [
        <category: 'accessor'>
        <comment: 'Returns the y component.'>
        ^yMove
    ]

    rotateRight [
        <category: 'helper'>
        <comment: 'Rotates the movement clockwise.'>
        | tmp |
        tmp := yMove negated.
        yMove := xMove.
        xMove := tmp
    ]

    rotateLeft [
        <category: 'helper'>
        <comment: 'Rotates the movement counterclockwise.'>
        | tmp |
        tmp := xMove negated.
        xMove := yMove.
        yMove := tmp
    ]

    asDirection [
        <category: 'helper'>
        <comment: 'Returns the symbolic direction.'>
        ^xMove = 0
            ifTrue: [ yMove = 0
                ifTrue: [ nil ]
                ifFalse: [ yMove > 0 ifTrue: [ 's' ] ifFalse: [ 'n' ] ]
            ] ifFalse: [ yMove = 0
                ifTrue: [ xMove > 0 ifTrue: [ 'e' ] ifFalse: [ 'w' ] ]
                ifFalse: [ xMove > 0
                    ifTrue: [ yMove > 0 ifTrue: [ 'se' ] ifFalse: [ 'ne' ] ]
                    ifFalse: [ yMove > 0 ifTrue: [ 'sw' ] ifFalse: [ 'nw' ] ]
                ]
            ]
    ]
]
