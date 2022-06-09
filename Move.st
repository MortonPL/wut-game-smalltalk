Object subclass: Move [
    | xMove yMove |

    Move class >> new [
        <category: 'instance creation'>
        ^Move x: 0 y: 0
    ]

    setX: x setY: y [
        x isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: x mustBe: Integer ].
        y isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: y mustBe: Integer ].
        xMove := x.
        yMove := y.
    ]
 
    Move class >> x: horizontal y: vertical [
        <category: 'instance creation'>
        | r |
        horizontal isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: horizontal mustBe: Integer ].
        vertical isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: vertical mustBe: Integer ].
        r := super new.
        r setX: horizontal setY: vertical.
        ^r
    ]

    dirMoveMap := Dictionary from: {
        #n -> (Move x: 0 y: -1).
        #e -> (Move x: 1 y: 0).
        #w -> (Move x: -1 y: 0).
        #s -> (Move x: 0 y: 1)
    }.
 
    Move class >> fromDirection: direction [
        <category: 'instance creation'>
        | r initialized |
        r := super new.
        initialized := false.
        ^dirMoveMap at: direction ifAbsent: [ ^self error: 'Incorrect argument for message fromDirection: must be one of #n, #e, #w, #s' ]
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
