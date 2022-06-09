Object subclass: Map [
    | tiles islands merchants outOfBounds |

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
            Island new: 'Northstable Island' occupiedBy: (merchants at: 1).
            Island new: 'Storm Reef'         occupiedBy: (merchants at: 2).
            Island new: 'White Tiger Island' occupiedBy: (merchants at: 3).
            Island new: 'Bishop Rock Island' occupiedBy: (merchants at: 4)
        }.
        tiles := {
            {
                ShallowWater new.
                ShallowWater new.
                ShallowWater new.
                islands at: 1.
                ShallowWater new.
                ShallowWater new
            }.
            {
                ShallowWater new.
                DeepWater    new.
                DeepWater    new.
                DeepWater    new.
                DeepWater    new.
                ShallowWater new
            }.
            {
                ShallowWater new.
                DeepWater    new.
                islands at: 2.
                DeepWater    new.
                DeepWater    new.
                ShallowWater new
            }.
            {
                islands at: 3.
                DeepWater    new.
                DeepWater    new.
                DeepWater    new.
                DeepWater    new.
                ShallowWater new
            }.
            {
                ShallowWater new.
                DeepWater    new.
                DeepWater    new.
                DeepWater    new.
                DeepWater    new.
                ShallowWater new
            }.
            {
                ShallowWater new.
                ShallowWater new.
                ShallowWater new.
                ShallowWater new.
                islands at: 4.
                ShallowWater new
            }
        }.
        outOfBounds := OutOfBounds new.
    ]

    atX: x atY: y  [
        <category: 'accessor'>
        | tile |
        tile := (tiles at: y ifAbsent: [ ^outOfBounds ]) at: x ifAbsent: [ ^outOfBounds ].
        ^tile
    ]
]
