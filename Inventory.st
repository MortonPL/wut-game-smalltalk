Object subclass: Inventory [
    | content |
    
    Inventory class >> new [
        <category: 'instance creation'>
        | o |
        o := super new.
        o init.
        ^o
    ]

    init [
        <category: 'initialization'>
        content := Dictionary new.
        ^self
    ]

    serialize: stream [
        content keysAndValuesDo: [:key :value | 
            stream nextPutAll: key; nextPut: $|;
                   nextPutAll: (value printString); nextPut: $|
        ].
        stream nextPut: $\.
    ]

    deserialize: stream [
        | stream2 key value |
        stream2 := ReadStream on: (stream upTo: $\).
        [stream2 atEnd] whileFalse: [
            key := (stream2 upTo: $|).
            value := (stream2 upTo: $|) asNumber.
            content at: key put: value
        ].
    ]

    modify: item by: difference [
        <category: 'mutator'>
        | amount |
        amount := self count: item.
        amount := amount + difference.
        (amount < 0)
            ifTrue: [ ^self error: 'New item amount negative' ].
        content at: item put: amount.
    ]

    count: item [
        <category: 'accessor'>
        ^content at: item ifAbsent: [ ^0 ]
    ]

    halve [
        <category: 'mutator'>
        content keysAndValuesDo: [ :key :value |
            content at: key put: ((value / 2) floor).
        ].
    ]

    show [
        <category: 'printer'>
        | items |
        items := content select: [ :value | value > 0 ].
        (items isEmpty)
            ifTrue: [
                'Your pockets are full of hopes and dreams.' displayNl.
            ]
            ifFalse: [
                'Your pockets are full with:' displayNl.
                items keysAndValuesDo: [ :key :value |
                    ' - ' display.
                    value display.
                    ' of `' display.
                    key display.
                    '`,' displayNl.
                ].
                'and nothing more.' displayNl.
            ].
    ]
]
