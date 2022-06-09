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
        inventory := nil
    ]

    position [
        <category: 'accessor'>
        ^position
    ]
]
