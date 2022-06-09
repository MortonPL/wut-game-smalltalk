Object subclass: Serializable [

    Serializable class >> new [
        <category: 'instance creation'>
        ^(super new)
    ]

    serialize: stream []
    deserialize: stream []
]

Serializable subclass: SerializableString [
    | string |

    SerializableString class >> new [
        <category: 'instance creation'>
        ^SerializableString s: ''
    ]

    SerializableString class >> s: str [
        <category: 'instance creation'>
        | o |
        o := super new.
        o init: str.
        ^o
    ]

    init: str [
        string := str
    ]

    serialize: stream [
        stream nextPutAll: string; nextPut: $|; nextPut: $\.
    ]

    deserialize: stream [
        string := (stream upTo: $|).
        stream upTo: $\.
    ]

    string [
        ^string
    ]

]
