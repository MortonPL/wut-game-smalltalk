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
        position := Position new.
        position setXLim: #(0 6) setYLim: #(0 6).
        inventory := nil
    ]

    position [
        <category: 'accessor'>
        ^position
    ]
]
