Object subclass: Offer [
    | buying selling |

    Offer class >> buying: buyingDict selling: sellingDict [
        ^(super new) buying: buyingDict; selling: sellingDict; yourself
    ]

    buying [
        <category: 'accessor'>
        ^buying
    ]

    selling [
        <category: 'accessor'>
        ^selling
    ]

    buying: buyingDict [
        <category: 'accessor'>
        buying := Dictionary from: buyingDict
    ]

    selling: sellingDict [
        <category: 'accessor'>
        selling := Dictionary from: sellingDict
    ]

    buyingPriceForSingle: itemName [
        | modifier basePrice |
        modifier := buying at: itemName ifAbsent: [ nil ].
        modifier isNil ifTrue: [ ^nil ].
        basePrice := BasePrice for: itemName.
        ^(basePrice * modifier) asInteger
    ]

    sellingPriceForSingle: itemName [
        | modifier basePrice |
        modifier := selling at: itemName ifAbsent: [ nil ].
        modifier isNil ifTrue: [ ^nil ].
        basePrice := BasePrice for: itemName.
        ^(basePrice * modifier) asInteger
    ]

    printOn: stream [
        stream nextPutAll: '[Selling]'; nl.
        selling keys sorted do: [ :each |
            stream nextPutAll: '  - ', each, ' for ', (self sellingPriceForSingle: each), ' coins each'; nl
        ].
        stream nl; nextPutAll: '[Buying]'; nl.
        buying keys sorted do: [ :each |
            stream nextPutAll: '  - ', each, ' for ', (self buyingPriceForSingle: each), ' coins each'; nl
        ].
    ]
]
