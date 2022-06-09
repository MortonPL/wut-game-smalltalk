Object subclass: Merchant [
    | name offer |

    Merchant class >> new: aString offering: anOffer [
        ^(super new) init: aString offering: anOffer; yourself
    ]

    init: aString offering: anOffer [
        name := aString.
        offer := anOffer
    ]

    name [
        <category: 'accessor'>
        ^name
    ]

    ask: topic [
        topic asSymbol = #offer ifTrue: [ offer printNl ]
    ]

    sells: itemName [
        offer selling at: itemName asSymbol ifAbsent: [ ^false ].
        ^true
    ]

    buys: itemName [
        offer buying at: itemName asSymbol ifAbsent: [ ^false ].
        ^true
    ]

    offer [
        <category: 'accessor'>
        ^offer
    ]
]
