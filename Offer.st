Object subclass: Offer [
    | buying selling |

    Offer class >> buying: buyingDict selling: sellingDict [
        ^(super new) buying: buyingDict; selling: sellingDict; yourself
    ]

    buying [
        <category: 'accessor'>
        <comment: 'Returns the buying dictionary.'>
        ^buying
    ]

    selling [
        <category: 'accessor'>
        <comment: 'Returns the selling dictionary.'>
        ^selling
    ]

    buying: buyingDict [
        <category: 'accessor'>
        <comment: 'Sets the buying dictionary.'>
        buying := buyingDict.
    ]

    selling: sellingDict [
        <category: 'accessor'>
        <comment: 'Sets the selling dictionary.'>
        selling := sellingDict.
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
        stream nextPutAll: '[Selling]'.
        selling keys sorted do: [ :each |
            stream nl; nextPutAll: '  - ', each, ' for ', (self sellingPriceForSingle: each) printString, ' coins each'
        ].
        stream nl; nl; nextPutAll: '[Buying]'.
        buying keys sorted do: [ :each |
            stream nl; nextPutAll: '  - ', each, ' for ', (self buyingPriceForSingle: each) printString, ' coins each'
        ].
    ]
]
