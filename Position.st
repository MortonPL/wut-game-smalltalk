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
        | r |
        r := super new.
        r setX: horizontal setY: vertical.
        ^r
    ]

    Position class >> x: horizontal y: vertical xLim: horizontalLimits yLim: verticalLimits [
        <category: 'instance creation'>
        <comment: 'Creates a move instance from coordinates with limits.'>
        | r |
        r := Position x: horizontal y: vertical.
        r setXLim: horizontalLimits setYLim: verticalLimits.
        ^r
    ]

    serialize: stream [
        <category: 'serde'>
        stream nextPutAll: (column printString); nextPut: $|;
               nextPutAll: (row printString); nextPut: $|;
               nextPut: $\.
    ]

    deserialize: stream [
        <category: 'serde'>
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

    = position [
        <category: 'operator'>
        <comment: 'Comparison operator.'>
        ^(position column = column) & (position row = row)
    ]

    - position [
        <category: 'operator'>
        <comment: 'Subtraction operator.'>
        ^Move x: (column - position column) y: (row - position row)
    ]

    hash [
        <category: 'operator'>
        <comment: 'Hashing function.'>
        ^('Position(', column printString, ',', row printString, ')') hash
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
