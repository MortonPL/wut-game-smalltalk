Object subclass: Tile [
    Tile class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        ^r
    ]

    describeCurrent [
        self subclassResponsibility
    ]

    describeRemote [
        self subclassResponsibility
    ]

    isLand [
        self subclassResponsibility
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
        ^'You are on a calm sea.'
    ]

    remoteMessages := {
        'You see a calm sea'.
        'The weather is beautiful'.
        'Just the borring ''ol sea'
    }.

    describeRemote [
        | rng random |
        rng := Random new.
        random := rng between: 1 and: 3.
        ^remoteMessages at: random
    ]

    isLand [
        ^false
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
        ^'The sea is unsteady. Your ship could be blown away at any moment...'
    ]

    remoteMessages := {
        'The sky is about to fall'.
        'You see the ocean raging'.
        'You are gonna have a bad time'
    }.

    describeRemote [
        | rng random |
        rng := Random new.
        random := rng between: 1 and: 3.
        ^remoteMessages at: random
    ]

    isLand [
        ^false
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
        ^'You are on the ', name, '. Rumours are you can trade with ', (merchant name), ' here. You gotta ask them.'
    ]

    remoteMessages := {
        'You spot a piece of land'.
        'You notice a landrats nest'.
        'Your barrelman sees land'
    }.

    describeRemote [
        | rng random |
        rng := Random new.
        random := rng between: 1 and: 3.
        ^remoteMessages at: random
    ]

    merchant [
        ^merchant
    ]

    isLand [
        ^true
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
        ^'Out of bounds.'
    ]

    remoteMessages := {
        'You smell no money'.
        'No adventure awaits you'.
        'Nothing of interest'
    }.

    describeRemote [
        | rng random |
        rng := Random new.
        random := rng between: 1 and: 3.
        ^remoteMessages at: random
    ]

    isLand [
        ^false
    ]
]
