Object subclass: Map [
    | tiles islands merchants outOfBounds |

    Map class >> new [
        <category: 'instance creation'>
        <comment: 'Creates a map instance.'>
        | map |
        map := super new.
        map init.
        ^map
    ]

    init [
        <category: 'initialization'>
        <comment: 'Initializes a map instance.'>
        merchants := {
            Merchant new: 'Morshu' offering: (Offer buying: (Dictionary from: {
                'rum' -> 0.9e.
                'gunpowder' -> 0.9e.
                'blunderbuss' -> 0.9e.
                'ration' -> 0.9e.
                'banana' -> 0.9e
            }) selling: (Dictionary from: {
                'rum' -> 1.0e.
                'gunpowder' -> 1.0e.
                'blunderbuss' -> 1.0e.
                'ration' -> 1.0e.
                'banana' -> 1.0e
            })).
            Merchant new: 'Tem' offering: (Offer buying: (Dictionary from: {
                'rum' -> 1.3e.
                'gunpowder' -> 0.5e.
                'blunderbuss' -> 0.5e.
                'ration' -> 0.7e.
                'banana' -> 1.1e
            }) selling: (Dictionary from: {
                'rum' -> 1.4e.
                'gunpowder' -> 0.6e.
                'blunderbuss' -> 0.6e.
                'ration' -> 1.8e.
                'map_piece_2' -> 1.0e
            })).
            Merchant new: 'Daniel Jacks' offering: (Offer buying: (Dictionary from: {
                'rum' -> 1.1e.
                'gunpowder' -> 1.5e.
                'blunderbuss' -> 1.1e.
                'ration' -> 0.7e.
                'banana' -> 1.3e
            }) selling: (Dictionary from: {
                'rum' -> 1.2e.
                'gunpowder' -> 1.6e.
                'blunderbuss' -> 1.2e.
                'ration' -> 0.8e.
                'mercenary' -> 1.0e
            })).
            Merchant new: 'Fred' offering: (Offer buying: (Dictionary from: {
                'rum' -> 1.1e.
                'gunpowder' -> 1.3e.
                'blunderbuss' -> 1.1e.
                'ration' -> 0.9e.
                'banana' -> 1.6e
            }) selling: (Dictionary from: {
                'rum' -> 1.2e.
                'gunpowder' -> 1.4e.
                'blunderbuss' -> 1.2e.
                'ration' -> 1.0e.
                'mercenary' -> 0.8e
            }))
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
        <comment: 'Returns the tile at provided position. Special tile is returned for out of bounds.'>
        | tile |
        tile := (tiles at: y ifAbsent: [ ^outOfBounds ]) at: x ifAbsent: [ ^outOfBounds ].
        ^tile
    ]
]
