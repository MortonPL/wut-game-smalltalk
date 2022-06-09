Object subclass: Tile [
    | pos |

    Tile class >> new: aPosition [
        <category: 'instance creation'>
        | r |
        r := super new.
        r init: aPosition.
        ^r
    ]

    init: aPosition [
        <category: 'initialization'>
        pos := aPosition
    ]

    describeFrom: aPosition [
        ^aPosition = pos
            ifTrue: [ self describeCurrent ]
            ifFalse: [ self describeRemote: (Direction asString: ((pos - aPosition) asDirection)) ]
    ]
]

Tile subclass: ShallowWater [
    ShallowWater class >> new: aPosition [
        <category: 'instance creation'>
        | r |
        r := super new: aPosition.
        ^r
    ]

    describeCurrent [
        <category: 'private'>
        ^'You are on a calm sea'
    ]

    describeRemote: aString [
        <category: 'private'>
        ^'You see a calm sea ', aString
    ]
]

Tile subclass: DeepWater [
    DeepWater class >> new: aPosition [
        <category: 'instance creation'>
        | r |
        r := super new: aPosition.
        ^r
    ]

    describeCurrent [
        <category: 'private'>
        ^'The sea is unsteady. Your ship could be blown away at any moment...'
    ]

    describeRemote: aString [
        <category: 'private'>
        ^'You see the ocean raging ', aString
    ]
]

Tile subclass: Island [
    | name merchant |

    Island class >> new: aPosition called: aString occupiedBy: aMerchant [
        <category: 'instance creation'>
        | r |
        r := super new: aPosition.
        r init: aString occupiedBy: aMerchant.
        ^r
    ]

    init: aString occupiedBy: aMerchant [
        name := aString.
        merchant := aMerchant
    ]

    describeCurrent [
        <category: 'private'>
        ^'You are on the ', name, '. Rumours are you can trade with ', (merchant name), ' here. You gotta ask them'
    ]

    describeRemote: aString [
        <category: 'private'>
        ^'You spot a piece of land ', aString
    ]
]
