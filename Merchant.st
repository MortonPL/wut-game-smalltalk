Object subclass: Merchant [
    | name offer |

    Merchant class >> new: aString offering: anOffer [
        <category: 'instance creation'>
        <comment: 'Creates a merchant instance.'>
        ^(super new) init: aString offering: anOffer; yourself
    ]

    init: aString offering: anOffer [
        <category: 'initialization'>
        <comment: 'Initializes a merchant instance.'>
        name := aString.
        offer := anOffer
    ]

    name [
        <category: 'accessor'>
        <comment: 'Returns the merchant name.'>
        ^name
    ]

    ask: topic [
        <category: 'printer'>
        <comment: 'Displays the offer.'>
        topic = 'offer' ifTrue: [ offer printNl ]
    ]

    sells: itemName [
        <category: 'TODO'>
        <comment: 'TODO'>
        offer selling at: itemName ifAbsent: [ ^false ].
        ^true
    ]

    buys: itemName [
        <category: 'TODO'>
        <comment: 'TODO'>
        offer buying at: itemName ifAbsent: [ ^false ].
        ^true
    ]

    offer [
        <category: 'accessor'>
        <comment: 'Returns the offer.'>
        ^offer
    ]
]
