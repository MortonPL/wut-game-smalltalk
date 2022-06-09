Object subclass: Tile [
    Tile class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        ^r
    ]
]

Tile subclass: ShallowWater [
    ShallowWater class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        ^r
    ]

    describeCurrent [
        <category: 'private'>
        ^'You are on a calm sea'
    ]

    describeRemote [
        <category: 'private'>
        ^'You see a calm sea'
    ]
]

Tile subclass: DeepWater [
    DeepWater class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        ^r
    ]

    describeCurrent [
        <category: 'private'>
        ^'The sea is unsteady. Your ship could be blown away at any moment...'
    ]

    describeRemote [
        <category: 'private'>
        ^'You see the ocean raging'
    ]
]

Tile subclass: Island [
    | name merchant |

    Island class >> new: aString occupiedBy: aMerchant [
        <category: 'instance creation'>
        | r |
        r := super new.
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

    describeRemote [
        <category: 'private'>
        ^'You spot a piece of land'
    ]
]

Tile subclass: OutOfBounds [
    OutOfBounds class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        ^r
    ]

    describeCurrent [
        <category: 'private'>
        ^'Out of bounds'
    ]

    describeRemote [
        <category: 'private'>
        ^'Out of bounds'
    ]
]
