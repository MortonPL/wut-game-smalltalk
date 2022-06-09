Object subclass: Position [
    | column row minColumn maxColumn minRow maxRow |

    Position class >> new [
        <category: 'instance creation'>
        ^Position x: 0 y: 0
    ]
 
    Position class >> x: horizontal y: vertical [
        <category: 'instance creation'>
        | r |
        r := super new.
        r setX: horizontal setY: vertical.
        ^r
    ]

    Position class >> x: horizontal y: vertical xLim: horizontalLimits yLim: verticalLimits [
        <category: 'instance creation'>
        | r |
        r := Position x: horizontal y: vertical.
        r setXLim: horizontalLimits setYLim: verticalLimits.
        ^r
    ]

    setX: x setY: y [
        x isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: x mustBe: Integer ].
        y isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: y mustBe: Integer ].
        column := x.
        row := y.
        ^self
    ]

    setXLim: xLim setYLim: yLim [
        xLim isArray ifFalse: [ SystemExceptions.WrongClass signalOn: xLim mustBe: Array ].
        yLim isArray ifFalse: [ SystemExceptions.WrongClass signalOn: yLim mustBe: Array ].
        minColumn := xLim at: 1.
        maxColumn := xLim at: 2.
        minRow := yLim at: 1.
        maxRow := yLim at: 2.
        minRow <= row & row <= maxRow ifFalse:
            [ SystemExceptions.ArgumentOutOfRange signalOn: row mustBeBetween: minRow and: maxRow ].
        minColumn <= column & column <= maxColumn ifFalse:
            [ SystemExceptions.ArgumentOutOfRange signalOn: column mustBeBetween: minColumn and: maxColumn ]
    ]

    tryMove: move [
        | newColumn newRow |
        (move isMemberOf: Move) ifFalse: [ SystemExceptions.WrongClass signalOn: move mustBe: Move ].
        newColumn := column + move x.
        newRow := row + move y.
        ^(minRow isNil or: [ minRow <= newRow ]) & (minColumn isNil or: [ minColumn <= newColumn ])
            & (maxRow isNil or: [ newRow <= maxRow ]) & (maxColumn isNil or: [ newColumn <= maxColumn ])
                ifTrue: [ column := column + move x. row := row + move y. true ]
                ifFalse: [ false ]
    ]

    printOn: stream [
        stream nextPutAll: 'Position ('.
        column printOn: stream.
        stream nextPutAll: ', '.
        row printOn: stream.
        stream nextPutAll: ')'
    ]
]
