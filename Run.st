game := Game new.
game run.

"
filename := 'test'.
fullname := 'saves/' , filename , '.sav'.
(File isAccessible: 'saves') ifFalse: [Directory create: 'saves'].
stream := FileStream open: fullname mode: FileStream write.
game getState serialize: stream.
stream close.
"

"
filename := 'test'.
fullname := 'saves/' , filename , '.sav'.
(File isReadable: fullname) ifFalse: [Exception signal: 'File doesn''t exist!'].
stream := FileStream open: fullname mode: FileStream read.
game getState deserialize: stream.
stream close.
"
