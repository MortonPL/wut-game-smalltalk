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
            Merchant new: 'Morshu' offering: (Offer buying: {
                #rum -> 0.9.
                #gunpowder -> 0.9.
                #blunderbuss -> 0.9.
                #ration -> 0.9.
                #banana -> 0.9
            } selling: {
                #rum -> 1.0.
                #gunpowder -> 1.0.
                #blunderbuss -> 1.0.
                #ration -> 1.0.
                #banana -> 1.0
            }).
            Merchant new: 'Tem' offering: (Offer buying: {
                #rum -> 1.3.
                #gunpowder -> 0.5.
                #blunderbuss -> 0.5.
                #ration -> 0.7.
                #banana -> 1.1
            } selling: {
                #rum -> 1.4.
                #gunpowder -> 0.6.
                #blunderbuss -> 0.6.
                #ration -> 1.8.
                #map_piece_1 -> 1.0
            }).
            Merchant new: 'Daniel Jacks' offering: (Offer buying: {
                #rum -> 1.1.
                #gunpowder -> 1.5.
                #blunderbuss -> 1.1.
                #ration -> 0.7.
                #banana -> 1.3
            } selling: {
                #rum -> 1.2.
                #gunpowder -> 1.6.
                #blunderbuss -> 1.2.
                #ration -> 0.8.
                #mercenary -> 1.0
            }).
            Merchant new: 'Fred' offering: (Offer buying: {
                #rum -> 1.1.
                #gunpowder -> 1.3.
                #blunderbuss -> 1.1.
                #ration -> 0.9.
                #banana -> 1.6
            } selling: {
                #rum -> 1.2.
                #gunpowder -> 1.4.
                #blunderbuss -> 1.2.
                #ration -> 1.0.
                #mercenary -> 0.8
            })
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
