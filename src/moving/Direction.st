"Direction class

Responsibilities:
* map symbolic directions to their full names"

Object subclass: Direction [
    dirStringMap := Dictionary from: {
        'n' -> 'North'.
        'e' -> 'East'.
        'w' -> 'West'.
        's' -> 'South'
    }.

    Direction class >> asString: aSymbol [
        <category: 'accessor'>
        <comment: 'Returns the name of a symbolic direction.'>
        ^dirStringMap at: aSymbol
    ]
]
