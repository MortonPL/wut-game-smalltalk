Object subclass: Merchant [
    | name |

    Merchant class >> new: aString [
        ^(super new) init: aString; yourself
    ]

    init: aString [
        name := aString
    ]

    name [
        <category: 'accessor'>
        ^name
    ]
]
