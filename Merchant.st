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
        topic asSymbol = #offer ifTrue: [ offer printLn ]
    ]
]
