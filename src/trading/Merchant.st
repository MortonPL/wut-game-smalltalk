"Merchant class

Responsibilities:
* buy/sell items from/to a Player
* answer Player's questions (especially about the offer)"

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
        (anOffer isMemberOf: Offer) ifFalse: [ SystemExceptions.WrongClass signalOn: anOffer mustBe: Offer ].
        offer := anOffer
    ]

    name [
        <category: 'accessor'>
        <comment: 'Returns the merchant name.'>
        ^name
    ]

    answer: topic [
        <category: 'printer'>
        <comment: 'Answers a topic.'>
        topic = 'offer' ifTrue: [ ^offer printNl ].
        topic = 'topics' ifTrue: [
            ('You can ask ', name, ' about:') displayNl.
            ^'  - offer' displayNl
        ].
        'Haven''t heard of it.' displayNl
    ]

    sells: itemName [
        <category: 'basic'>
        <comment: 'Checks if merchant has an item in his selling offer (returning true/false)'>
        offer selling at: itemName ifAbsent: [ ^false ].
        ^true
    ]

    buys: itemName [
        <category: 'basic'>
        <comment: 'Checks if merchant has an item in his buying offer (returning true/false)'>
        offer buying at: itemName ifAbsent: [ ^false ].
        ^true
    ]

    offer [
        <category: 'accessor'>
        <comment: 'Returns the offer.'>
        ^offer
    ]
]
