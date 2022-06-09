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
        items := content values select: [ :value | value > 0 ].
        (items isEmpty)
            ifTrue: [
                'You have nothing.' displayNl.
            ]
            ifFalse: [
                'You have:' displayNl.
                items keysAndValuesDo: [ :key :value |
                    '  - ' display.
                    value display.
                    ' of ' display.
                    key display.
                    ',' displayNl.
                ].
            ].
    ]

    itemWorth := Dictionary from: {
        'balls' -> 1.
        'cubes' -> 5.
        'smetana' -> 100
    }.

    worth [
        <category: 'helper'>
        | totalWorth |
        totalWorth := 0.
        content keysAndValuesDo: [ :key :value |
            totalWorth := totalWorth + (value * (itemWorth at: key ifAbsent: [ 0 ])).
        ].
        ^totalWorth
    ]
]
