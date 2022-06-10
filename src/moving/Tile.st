"Tile interface"

Object subclass: Tile [
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


"ShallowWater class

Responsibilities:
* represent a shallow water Tile
* describe itself"

Tile subclass: ShallowWater [
    ShallowWater class >> new [
        <category: 'instance creation'>
        <comment: 'Creates ShallowWater tile instance.'>
        ^super new
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


"DeepWater class

Responsibilities:
* represent a deep water Tile
* describe itself"

Tile subclass: DeepWater [
    DeepWater class >> new [
        <category: 'instance creation'>
        <comment: 'Creates DeepWater tile instance.'>
        ^super new
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


"Island class

Responsibilities:
* represent an island Tile
* describe itself"

Tile subclass: Island [
    | name merchant |

    Island class >> new: aString occupiedBy: aMerchant [
        <category: 'instance creation'>
        <comment: 'Creates Island tile instance.'>
        ^(super new) init: aString occupiedBy: aMerchant; yourself
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


"OutOfBounds class

Responsibilities:
* represent an inaccessible Tile
* describe itself"

Tile subclass: OutOfBounds [
    OutOfBounds class >> new [
        <category: 'instance creation'>
        <comment: 'Creates OutOfBounds tile instance.'>
        ^super new
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
