Error subclass: FallingOffTheEdgeOfTheWorld [
    FallingOffTheEdgeOfTheWorld class >> new [
        | r |
        r := super new.
        ^r
    ]
]

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
        x isInteger ifFalse: [ ^self error: 'Invalid argument for message setX: must be an integer' ].
        y isInteger ifFalse: [ ^self error: 'Invalid argument for message setY: must be an integer' ].
        column := x.
        row := y.
        ^self
    ]

    setXLim: xLim setYLim: yLim [
        xLim isArray & (xLim size = 2) ifFalse:
            [ ^self error: 'Invalid argument for message xLim: must be an Array of size 2' ].
        yLim isArray & (yLim size = 2) ifFalse:
            [ ^self error: 'Invalid argument for message yLim: must be an Array of size 2' ].
        minColumn := xLim at: 1.
        maxColumn := xLim at: 2.
        minRow := yLim at: 1.
        maxRow := yLim at: 2.
        minRow <= row & row <= maxRow & minColumn <= column & column <= maxColumn ifFalse:
            [ ^self error: 'Position is outside the set limits' ]
    ]

    + move [
        | newColumn newRow |
        (move isMemberOf: Move) ifFalse: [ ^self error: 'Invalid argument for message +: must be a Move instance' ].
        newColumn := column + move x.
        newRow := row + move y.
        (minRow isNil or: [ minRow <= newRow ]) & (minColumn isNil or: [ minColumn <= newColumn ])
            & (maxRow isNil or: [ newRow <= maxRow ]) & (maxColumn isNil or: [ newColumn <= maxColumn ]) ifFalse:
                [ FallingOffTheEdgeOfTheWorld new signal ].
        column := column + move x.
        row := row + move y.
        ^self
    ]

    printOn: stream [
        stream nextPutAll: 'Position ('.
        column printOn: stream.
        stream nextPutAll: ', '.
        row printOn: stream.
        stream nextPutAll: ')'
    ]
]
