Object subclass: BasePrice [
    prices := Dictionary from: {
        #rum -> 10.
        #blunderbuss -> 250.
        #ration -> 10.
        #map_piece_2 -> 1500.
        #banana -> 12.
        #mercenary -> 500
    }.

    BasePrice class >> for: itemName [
        ^prices at: itemName asSymbol
            ifAbsent: [ SystemExceptions.InvalidArgument signalOn: itemName reason: 'Item not found' ]
    ]
]
