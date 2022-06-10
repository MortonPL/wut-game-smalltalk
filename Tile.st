Object subclass: Tile [
    Tile class >> new [
        <category: 'instance creation'>
        <comment: 'Abstraction.'>
        | r |
        r := super new.
        ^r
    ]

    describeCurrent [
        <category: 'helper'>
        <comment: 'Describes the tile here.'>
        self subclassResponsibility
    ]

    describeRemote [
        <category: 'helper'>
        <comment: 'Describes the tile away.'>
        self subclassResponsibility
    ]
]

Tile subclass: ShallowWater [
    ShallowWater class >> new [
        <category: 'instance creation'>
        <comment: 'Creates ShallowWater tile instance.'>
        | r |
        r := super new.
        ^r
    ]

    describeCurrent [
        <category: 'helper'>
        <comment: 'Describes the tile here.'>
        ^'You are on a calm sea.'
    ]

    remoteMessages := {
        'You see a calm sea'.
        'The weather is beautiful'.
        'Just the borring ''ol sea'
    }.

    describeRemote [
        <category: 'helper'>
        <comment: 'Describes the tile away.'>
        | rng random |
        rng := Random new.
        random := rng between: 1 and: 3.
        ^remoteMessages at: random
    ]
]

Tile subclass: DeepWater [
    DeepWater class >> new [
        <category: 'instance creation'>
        <comment: 'Creates DeepWater tile instance.'>
        | r |
        r := super new.
        ^r
    ]

    describeCurrent [
        <category: 'helper'>
        <comment: 'Describes the tile here.'>
        ^'The sea is unsteady. Your ship could be blown away at any moment...'
    ]

    remoteMessages := {
        'The sky is about to fall'.
        'You see the ocean raging'.
        'You are gonna have a bad time'
    }.

    describeRemote [
        <category: 'helper'>
        <comment: 'Describes the tile away.'>
        | rng random |
        rng := Random new.
        random := rng between: 1 and: 3.
        ^remoteMessages at: random
    ]
]

Tile subclass: Island [
    | name merchant |

    Island class >> new: aString occupiedBy: aMerchant [
        <category: 'instance creation'>
        <comment: 'Creates Island tile instance.'>
        | r |
        r := super new.
        r init: aString occupiedBy: aMerchant.
        ^r
    ]

    init: aString occupiedBy: aMerchant [
        <category: 'initialization'>
        <comment: 'Initializes Island tile instance with name and merchant.'>
        name := aString.
        merchant := aMerchant
    ]

    describeCurrent [
        <category: 'helper'>
        <comment: 'Describes the tile here.'>
        ^'You are on the ', name, '. Rumours are you can trade with ', (merchant name), ' here. You gotta ask them.'
    ]

    remoteMessages := {
        'You spot a piece of land'.
        'You notice a landrats nest'.
        'Your barrelman sees land'
    }.

    describeRemote [
        <category: 'helper'>
        <comment: 'Describes the tile away.'>
        | rng random |
        rng := Random new.
        random := rng between: 1 and: 3.
        ^remoteMessages at: random
    ]

    merchant [
        <category: 'accessor'>
        <comment: 'Returns the merchant.'>
        ^merchant
    ]
]

Tile subclass: OutOfBounds [
    OutOfBounds class >> new [
        <category: 'instance creation'>
        <comment: 'Creates OutOfBounds tile instance.'>
        | r |
        r := super new.
        ^r
    ]

    describeCurrent [
        <category: 'helper'>
        <comment: 'Describes the tile here.'>
        ^'Out of bounds.'
    ]

    remoteMessages := {
        'You smell no money'.
        'No adventure awaits you'.
        'Nothing of interest'
    }.

    describeRemote [
        <category: 'helper'>
        <comment: 'Describes the tile away.'>
        | rng random |
        rng := Random new.
        random := rng between: 1 and: 3.
        ^remoteMessages at: random
    ]
]
