"Inventory class

Responsibilities:
* store the game state (Player's name, Position, Inventory)"

Object subclass: GameState [
    | playerName position inventory |

    GameState class >> new [
        <category: 'instance creation'>
        <comment: 'Creates a game state instance.'>
        ^(super new) init; yourself
    ]

    init [
        <category: 'initialization'>
        <comment: 'Initializes a game state instance.'>
        playerName := SerializableString s: 'foe'.
        position := Position x: 1 y: 1 xLim: #(1 6) yLim: #(1 6).
        inventory := Inventory new.
        inventory modify: 'mercenary' by: 1.
        inventory modify: 'coin' by: 100.
    ]

    serialize: stream [
        <category: 'serde'>
        <comment: 'Serializes the instance to a stream.'>
        playerName serialize: stream.
        position serialize: stream.
        inventory serialize: stream
    ]

    deserialize: stream [
        <category: 'serde'>
        <comment: 'Deserializes the instance from a stream.'>
        playerName deserialize: stream.
        position deserialize: stream.
        inventory deserialize: stream
    ]

    position [
        <category: 'accessor'>
        <comment: 'Returns the position.'>
        ^position
    ]

    inventory [
        <category: 'accessor'>
        <comment: 'Returns the inventory.'>
        ^inventory
    ]
]
