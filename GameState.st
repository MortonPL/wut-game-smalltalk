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
        position := Position x: 0 y: 0 xLim: #(0 6) yLim: #(0 6).
        inventory := Inventory new.
        inventory modify: 'balls' by: 99.
        inventory modify: 'cubes' by: 100.
        inventory modify: 'smetana' by: 1.
        inventory modify: 'mercenary' by: 5.
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
