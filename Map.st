Object subclass: Map [
    | tiles islands merchants |

    Map class >> new [
        | map |
        map := super new.
        map init.
        ^map
    ]

    init [
        merchants := {
            Merchant new: 'Morshu'.
            Merchant new: 'Tem'.
            Merchant new: 'Daniel Jacks'.
            Merchant new: 'Fred'
        }.
        islands := {
            Island new: (Position x: 4 y: 1) called: 'Northstable Island' occupiedBy: (merchants at: 1).
            Island new: (Position x: 3 y: 3) called: 'Storm Reef'         occupiedBy: (merchants at: 2).
            Island new: (Position x: 1 y: 4) called: 'White Tiger Island' occupiedBy: (merchants at: 3).
            Island new: (Position x: 5 y: 6) called: 'Bishop Rock Island' occupiedBy: (merchants at: 4)
        }.
        tiles := {
            {
                ShallowWater new: (Position x: 1 y: 1).
                ShallowWater new: (Position x: 2 y: 1).
                ShallowWater new: (Position x: 3 y: 1).
                islands at: 1.
                ShallowWater new: (Position x: 5 y: 1).
                ShallowWater new: (Position x: 6 y: 1)
            }.
            {
                ShallowWater new: (Position x: 1 y: 2).
                DeepWater    new: (Position x: 2 y: 2).
                DeepWater    new: (Position x: 3 y: 2).
                DeepWater    new: (Position x: 4 y: 2).
                DeepWater    new: (Position x: 5 y: 2).
                ShallowWater new: (Position x: 6 y: 2)
            }.
            {
                ShallowWater new: (Position x: 1 y: 3).
                DeepWater    new: (Position x: 2 y: 3).
                islands at: 2.
                DeepWater    new: (Position x: 4 y: 3).
                DeepWater    new: (Position x: 5 y: 3).
                ShallowWater new: (Position x: 6 y: 3)
            }.
            {
                islands at: 3.
                DeepWater    new: (Position x: 2 y: 4).
                DeepWater    new: (Position x: 3 y: 4).
                DeepWater    new: (Position x: 4 y: 4).
                DeepWater    new: (Position x: 5 y: 4).
                ShallowWater new: (Position x: 6 y: 4)
            }.
            {
                ShallowWater new: (Position x: 1 y: 5).
                DeepWater    new: (Position x: 2 y: 5).
                DeepWater    new: (Position x: 3 y: 5).
                DeepWater    new: (Position x: 4 y: 5).
                DeepWater    new: (Position x: 5 y: 5).
                ShallowWater new: (Position x: 6 y: 5)
            }.
            {
                ShallowWater new: (Position x: 1 y: 6).
                ShallowWater new: (Position x: 2 y: 6).
                ShallowWater new: (Position x: 3 y: 6).
                ShallowWater new: (Position x: 4 y: 6).
                islands at: 4.
                ShallowWater new: (Position x: 6 y: 6)
            }
        }.
    ]

    atX: x atY: y  [
        <category: 'accessor'>
        | tile |
        tile := (tiles at: y) at: x.
        ^tile
    ]
]
