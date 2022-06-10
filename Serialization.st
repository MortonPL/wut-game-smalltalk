Object subclass: Serializable [
    Serializable class >> new [
        <category: 'instance creation'>
        <comment: 'Abstraction.'>
        ^(super new)
    ]

    serialize: stream [
        <category: 'serde'>
        self subclassResponsibility
    ]

    deserialize: stream [
        <category: 'serde'>
        self subclassResponsibility
    ]
]

Serializable subclass: SerializableString [
    | string |

    SerializableString class >> new [
        <category: 'instance creation'>
        <comment: 'Creates a string instance.'>
        ^SerializableString s: ''
    ]

    SerializableString class >> s: str [
        <category: 'instance creation'>
        <comment: 'Creates a string instance with given string.'>
        | o |
        o := super new.
        o init: str.
        ^o
    ]

    init: str [
        <category: 'initialization'>
        <comment: 'Initializes a string instance.'>
        string := str
    ]

    serialize: stream [
        <category: 'serde'>
        stream nextPutAll: string; nextPut: $|; nextPut: $\.
    ]

    deserialize: stream [
        <category: 'serde'>
        string := (stream upTo: $|).
        stream upTo: $\.
    ]

    string [
        <category: 'accessor'>
        <comment: 'Returns the inner string'>
        ^string
    ]
]
