Object subclass: Direction [
    dirStringMap := Dictionary from: {
        #nw -> 'Northwest'.
        #n -> 'North'.
        #ne -> 'Northeast'.
        #e -> 'East'.
        #w -> 'West'.
        #sw -> 'Southwest'.
        #s -> 'South'.
        #se -> 'Southeast'
    }.

    Direction class >> asString: aSymbol [
        <category: 'accessor'>
        <comment: 'Returns the name of a symbolic direction.'>
        ^dirStringMap at: aSymbol
    ]
]
