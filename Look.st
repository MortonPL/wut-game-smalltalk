Map extend [
    lookAround: position [
        <category: 'printer'>
        | x y |
        x := position column.
        y := position row.
        (self atX: x atY: y) describeCurrent displayNl.
        ((self atX: x + 1 atY: y) describeRemote, ' up east.') displayNl.
        ((self atX: x atY: y + 1) describeRemote, ' up south.') displayNl.
        ((self atX: x - 1 atY: y) describeRemote, ' up west.') displayNl.
        ((self atX: x atY: y - 1) describeRemote, ' up north.') displayNl.
    ]
]
