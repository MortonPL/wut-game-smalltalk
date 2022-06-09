Array extend [
    "Print strings from array in separate lines."
    printLines [
        self do: [ :string | Transcript show: string; nl ]
    ]
]
