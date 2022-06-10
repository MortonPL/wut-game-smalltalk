"Serializable interface"

Object subclass: Serializable [
    serialize: stream [
        <category: 'serde'>
        <comment: 'Serializes the instance to a stream.'>
        self subclassResponsibility
    ]

    deserialize: stream [
        <category: 'serde'>
        <comment: 'Deserializes the instance from a stream.'>
        self subclassResponsibility
    ]
]


"SerializableString class

Responsibilities:
* serialize/deserialize wrapped string"

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
        ^(super new) init: str; yourself
    ]

    init: str [
        <category: 'initialization'>
        <comment: 'Initializes a string instance.'>
        string := str
    ]

    serialize: stream [
        <category: 'serde'>
        <comment: 'Serializes the instance to a stream.'>
        stream nextPutAll: string; nextPut: $|; nextPut: $\.
    ]

    deserialize: stream [
        <category: 'serde'>
        <comment: 'Deserializes the instance from a stream.'>
        string := (stream upTo: $|).
        stream upTo: $\.
    ]

    string [
        <category: 'accessor'>
        <comment: 'Returns the inner string'>
        ^string
    ]
]
