"serialization PoC"

Object subclass: Serializable [
    | value |

    Serializable class >> new [
        <category: 'instance creation'>
        | obj |
        obj := super new.
        obj init.
        ^obj
    ]

    init [
        <category: 'initialization'>
        value := 0
    ]

    getValue [ ^value ]
    setValue: v [ value := v ]

    "przykładowe serdle"
    serialize: stream [ stream nextPutAll: (value printString); nextPut: $| ]
    deserialize: stream [ value := (stream upTo: $|) asNumber. "asBoolean, asFloat" ]
]

b1 := Serializable new.
b2 := Serializable new.

b1 setValue: 3.
b2 setValue: 4.

filename := 'test'.
fullname := 'saves/' , filename , '.sav'.

(File isAccessible: 'saves') ifFalse: [Directory create: 'saves'].
stream := FileStream open: fullname mode: FileStream write.
b1 serialize: stream.
b2 serialize: stream.
stream close.

b1 setValue: 1.
b2 setValue: 2.

(File isReadable: fullname) ifFalse: [Exception signal: 'File doesn''t exist!'].
stream := FileStream open: fullname mode: FileStream read.
b1 deserialize: stream.
b2 deserialize: stream.
stream close.
