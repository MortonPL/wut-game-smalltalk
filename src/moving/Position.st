"Position class

Responsibilities:
* represent a position on the world Map
* describe itself"

Serializable subclass: Position [
    | column row minColumn maxColumn minRow maxRow |

    Position class >> new [
        <category: 'instance creation'>
        <comment: 'Creates a position instance.'>
        ^Position x: 0 y: 0
    ]
 
    Position class >> x: horizontal y: vertical [
        <category: 'instance creation'>
        <comment: 'Creates a position instance from coordinates.'>
        ^(super new) setX: horizontal setY: vertical; yourself
    ]

    Position class >> x: horizontal y: vertical xLim: horizontalLimits yLim: verticalLimits [
        <category: 'instance creation'>
        <comment: 'Creates a move instance from coordinates with limits.'>
        ^(Position x: horizontal y: vertical) setXLim: horizontalLimits setYLim: verticalLimits; yourself
    ]

    serialize: stream [
        <category: 'serde'>
        <comment: 'Serializes the instance to a stream.'>
        stream nextPutAll: (column printString); nextPut: $|;
               nextPutAll: (row printString); nextPut: $|;
               nextPut: $\.
    ]

    deserialize: stream [
        <category: 'serde'>
        <comment: 'Deserializes the instance from a stream.'>
        column := (stream upTo: $|) asNumber.
        row := (stream upTo: $|) asNumber.
        stream upTo: $\.
    ]

    setX: x setY: y [
        <category: 'initialization'>
        <comment: 'Initializes the position instance with coordinates.'>
        x isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: x mustBe: Integer ].
        y isInteger ifFalse: [ SystemExceptions.WrongClass signalOn: y mustBe: Integer ].
        column := x.
        row := y.
        ^self
    ]

    setXLim: xLim setYLim: yLim [
        <category: 'initialization'>
        <comment: 'Initializes the position instance with limits.'>
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
        <category: 'helper'>
        <comment: 'Tries to move the position. Returns false if the move goes out of limits.'>
        | newColumn newRow |
        (move isMemberOf: Move) ifFalse: [ SystemExceptions.WrongClass signalOn: move mustBe: Move ].
        newColumn := column + move x.
        newRow := row + move y.
        ^(minRow isNil or: [ minRow <= newRow ]) & (minColumn isNil or: [ minColumn <= newColumn ])
            & (maxRow isNil or: [ newRow <= maxRow ]) & (maxColumn isNil or: [ newColumn <= maxColumn ])
                ifTrue: [ column := column + move x. row := row + move y. true ]
                ifFalse: [ false ]
    ]

    column [
        <category: 'accessor'>
        <comment: 'Returns the x component.'>
        ^column
    ]

    row [
        <category: 'accessor'>
        <comment: 'Returns the y component.'>
        ^row
    ]

    printOn: stream [
        <category: 'printer'>
        <comment: 'Displays the positon.'>
        stream nextPutAll: 'Position ('.
        column printOn: stream.
        stream nextPutAll: ', '.
        row printOn: stream.
        stream nextPutAll: ')'
    ]
]
