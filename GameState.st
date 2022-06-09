Object subclass: GameState [
    | playerName position inventory |

    GameState class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        r init.
        ^r
    ]

    init [
        <category: 'initialization'>
        playerName := 'foe'.
        position := Position x: 1 y: 1 xLim: #(1 6) yLim: #(1 6).
        inventory := Inventory new.
        inventory modify: 'mercenary' by: 1.
        inventory modify: 'coin' by: 100.
    ]

    position [
        <category: 'accessor'>
        ^position
    ]

    inventory [
        <category: 'accessor'>
        ^inventory
    ]
]
