"Move class

Responsibilities:
* represent a move from one Position to another"

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
        horizontal isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: horizontal mustBe: Integer ].
        vertical isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: vertical mustBe: Integer ].
        ^(super new) setX: horizontal setY: vertical; yourself
    ]

    dirMoveMap := Dictionary from: {
        'n' -> [ Move x:  0 y: -1 ].
        'e' -> [ Move x:  1 y:  0 ].
        'w' -> [ Move x: -1 y:  0 ].
        's' -> [ Move x:  0 y:  1 ]
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
]
