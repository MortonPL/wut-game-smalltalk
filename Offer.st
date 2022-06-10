Object subclass: Offer [
    | buying selling |

    Offer class >> buying: buyingDict selling: sellingDict [
        ^(super new) buying: buyingDict; selling: sellingDict; yourself
    ]

    buying [
        <category: 'accessor'>
        <comment: 'Returns the buying offer message.'>
        ^buying
    ]

    selling [
        <category: 'accessor'>
        <comment: 'Returns the selling offer message.'>
        ^selling
    ]

    buying: buyingDict [
        <category: 'accessor'>
        <comment: 'Returns the buying dictionary.'>
        buying := Dictionary from: buyingDict
    ]

    selling: sellingDict [
        <category: 'accessor'>
        <comment: 'Returns the selling dictionary.'>
        selling := Dictionary from: sellingDict
    ]

    buyingPriceForSingle: itemName [
        <category: 'helper'>
        <comment: 'Returns the buy price of specific item.'>
        | modifier basePrice |
        modifier := buying at: itemName ifAbsent: [ nil ].
        modifier isNil ifTrue: [ ^nil ].
        basePrice := BasePrice for: itemName.
        ^(basePrice * modifier) asInteger
    ]

    sellingPriceForSingle: itemName [
        <category: 'helper'>
        <comment: 'Returns the sell price of specific item.'>
        | modifier basePrice |
        modifier := selling at: itemName ifAbsent: [ nil ].
        modifier isNil ifTrue: [ ^nil ].
        basePrice := BasePrice for: itemName.
        ^(basePrice * modifier) asInteger
    ]

    printOn: stream [
        <category: 'printer'>
        <comment: 'Displays the offers.'>
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
