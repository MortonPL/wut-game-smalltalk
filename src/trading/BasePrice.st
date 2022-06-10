"BasePrice class

Responsibilities:
* store base prices for all the available goods"

Object subclass: BasePrice [
    prices := Dictionary from: {
        'rum'         ->   10.
        'gunpowder'   ->   10.
        'blunderbuss' ->  250.
        'ration'      ->   10.
        'map_piece_2' -> 1500.
        'banana'      ->   12.
        'mercenary'   ->  500
    }.

    BasePrice class >> for: itemName [
        <category: 'accessor'>
        <comment: 'Returns the price of an item.'>
        ^prices at: itemName
            ifAbsent: [ SystemExceptions.InvalidArgument signalOn: itemName reason: 'Item not found' ]
    ]
]
