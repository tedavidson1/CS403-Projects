Object subclass: Main [
  | count roster |

  Main class >> new [
    <category: 'instance creation'>
    | r |
    r := super new.
    r init.
    ^r
  ]

  init [
    <category: 'initialization'>
    count := self setCount. "go get the size of the array"
    (count = 0)
    ifTrue: [
      'There are no employees.' displayNl.
      ObjectMemory quit.
    ].
"count displayNl."
    roster := self setRoster.

  ]

  setCount [
    <category: 'finds total number of employees'>
    | f total b filename |
    "already know that this is a valid file"
    f := FileStream open: (Smalltalk arguments at: 1) mode: FileStream read.
    "f is a temp variable just for traversing the stream"
    total := 0. "default value set"
    b := f nextLine. "gets line 1"
    [b isNil or: [b size < 3]] whileFalse:
      [
        total := total + 1.
        b := f nextLine.
      ].
      f close.
    ^total
  ]

  getCount [
    <category: 'handles count'>
    | holder |
    holder := count.
    ^holder
  ]

  setRoster [
    <category: 'creates employee list'>
    | list f b cur holder rs member pieces pos hired |
    cur := 1."variable for indexing array the built employee array"

    list := Array new: count. "list will be used to hold Employees that are made. This will be returned"
    f := FileStream open: (Smalltalk arguments at: 1) mode: FileStream read. "already know this is safe"
    b := f nextLine. "gets the first line"
    [b isNil or: [b size < 3]] whileFalse: "while we are not at the end of the file"
      [
        pieces := Array new: 6. "array for holding components of an employee"
        rs := ReadStream on: b. "make a new stream to go over the line"
        pos := 1. "arrays start at 1"
        [rs atEnd] whileFalse: [ "while we are not at the end of the line"
          holder := rs upTo: $ . "get the next word"
          "holder displayNl. print it just to confirm"
          pieces at: pos put: holder. "list at that index is that word"
          pos := pos + 1.
        ].
        "with pieces filled, you now just call the proper function to make the object"
        hired := self buildEmployee: pieces. "sends data to buildEmployee to build it"
        list at: cur put: hired. "put the made employee at index cur"
        b := f nextLine. "b gets the next line"
        cur := cur + 1. "the index is increased"
      ].
      f close.
      ^list "return the list of employees"
  ]

  getRoster [
  <category: 'gets the roster'>
  | holder |
  holder := roster.
  ^roster
  ]

  "given a list of data, returns the proper employee object"
  buildEmployee: attr [
    <category: 'creates an employee to return'>
    | hire |
    ((attr at: 1) = 'salaried')
      ifTrue:[ "Constructors could GREATLY simplfy this filth"
        hire:= Salaried new.
        hire setFirst: (attr at: 2).
        hire setLast: (attr at: 3).
        hire setSalary: ((attr at: 4) asNumber).
        ^hire
        ].

      ((attr at: 1) = 'hourly')
        ifTrue:[
          hire := Hourly new.
          hire setFirst: (attr at: 2).
          hire setLast: (attr at: 3).
          hire setHours: ((attr at: 4) asNumber).
          hire setRate: ((attr at: 5) asNumber).
          ^hire
        ].

        ((attr at: 1) = 'commission')
          ifTrue:[
            hire := Commission new.
            hire setFirst: (attr at: 2).
            hire setLast: (attr at: 3).
            hire setminSalary: ((attr at: 4) asNumber).
            hire setnumSold: ((attr at: 5) asNumber).
            hire setPercent: ((attr at: 6) asNumber).
            ^hire
          ].

      ]

      calculateEmployees: op in: threshold [
        <category: 'tallies the number of applicable employees'>
        | total index amount |
        total := 0.
        amount := 0.00.
        index := 1.
        [index <= roster size]
        whileTrue: [ "call get earning on each employee object"
        amount := ((roster at: index) getEarning).
        "amount displayNl."
        ((self check: amount use: op in: threshold) = 1)
        ifTrue:[total := total + 1.].
        index := index + 1.
        ].
        ^total.
      ]

  "method to check the op and if it is true"
  "returns 1 if true, 0 if false"
  check: value use: op in: threshold [
    <category: 'handles operations involving values'>
    (op = 'eq')
      ifTrue: [(value = threshold) ifTrue: [^1] ifFalse:[^0].].
    (op = 'ne')
      ifTrue: [(value ~= threshold) ifTrue: [^1] ifFalse:[^0].].
    (op = 'ge')
      ifTrue: [(value >= threshold) ifTrue: [^1] ifFalse:[^0].].
    (op = 'le')
      ifTrue: [(value <= threshold) ifTrue: [^1] ifFalse:[^0].].
    (op = 'gt')
      ifTrue: [(value > threshold) ifTrue: [^1] ifFalse:[^0].].
    (op = 'lt')
      ifTrue: [(value < threshold) ifTrue: [^1] ifFalse:[^0].].
  ^0
  ]

  printEmployees: op in: threshold [
    <category: 'outputs valid employees'>
    | index amount |
    amount := 0.00.
    index := 1.
    [index <= roster size]
    whileTrue: [ "call get earning on each employee object"
    amount := ((roster at: index) getEarning).
    "amount displayNl."
    (( self check: amount use: op in: threshold) = 1)
    ifTrue:[
      (roster at: index) getInfo.
      'earned $' display.
      amount displayNl.
      '' displayNl.
    ].
    index := index + 1.
    ].
  ]

] "END OF CLASS"

"actual, normal main method code begins here"
"I first do all of the checking to ensure that I have actual input"
many := Smalltalk arguments size. "how many command line items"
(many ~= 2 and: [many ~= 4])
ifTrue:[
  'Usage: gst employee.st salaried.st hourly.st commission.st -f main.st action' displayNl.
  'or' displayNl.
  'Usage: gst employee.st salaried.st hourly.st commission.st -f main.st action operator threshold' displayNl.
  '' displayNl.
  'Valid actions: count print min max total avg' displayNl.
  'Valid operators: eq ne gt ge lt le' displayNl.
  ObjectMemory quit.
].

"check for the file status"
f := FileStream open: (Smalltalk arguments at: 1) mode: FileStream read
ifFail: [
          'Unable to open ' display.
          (Smalltalk arguments at: 1) display.
          ' for reading' displayNl.
          ObjectMemory quit.
        ].
f close.
"if we haven't failed yet, it means we are good to go"
"1: file 2: command 3: op 4:  threshold"
runcode := Main new.
"employee file is now read and processed. We can stage an operation on it now"
op := 'ge'.
threshold := 0.00

(many = 4)
ifTrue:[
  op := (Smalltalk arguments at: 3).
  threshold := ((Smalltalk arguments at: 4) asNumber).
].
tally := runcode calculateEmployees: op in: threshold.
(tally = 0)
ifTrue: [
  'There are no employees satisfied the specified condition.' displayNl.
  ObjectMemory quit.
].

"now we do the rest of the blocks"
action := (Smalltalk arguments at: 2).
(action = 'count')
ifTrue:[
  'There are ' display.
  tally display.
  ' employees.' displayNl.
  ObjectMemory quit.
].

(action = 'print')
ifTrue: [
  runcode printEmployees: op in: threshold.
  ObjectMemory quit.
].

(action = 'min') "just printing the employees for some reason"
ifTrue: [
  index := 1.
  list := runcode getRoster. "gets roster"
  lowest := -1.
[index <= list size]
whileTrue: [
amount := ((list at: index) getEarning).
(amount > lowest)
ifTrue:[lowest := amount.].
index := index + 1.
].
lowest := lowest + 1.
index := 1.

  [index <= list size] "iterate"
  whileTrue: [
  amount := ((list at: index) getEarning). "get the amount"
  "if the op is valid and amount is less than current lowest, update"
  temp := (runcode check: amount use: op in: threshold).
  (temp = 1 and: [amount<lowest])
  ifTrue:[
    lowest := amount.
  ].
  index := index + 1.
  ].
runcode printEmployees: 'eq' in: lowest.
ObjectMemory quit.
].

(action = 'max') "just printing the employees for some reason"
ifTrue: [
  index := 1.
  list := runcode getRoster. "gets roster"
  highest := -1. "placeholder"
  [index <= list size] "iterate"
  whileTrue: [
  amount := ((list at: index) getEarning). "get the amount"
  "if the op is valid and amount is less than current lowest, update"
  temp := (runcode check: amount use: op in: threshold).
  (temp = 1 and: [amount>highest])
  ifTrue:[
    highest := amount.
  ].
  index := index + 1.
  ].
runcode printEmployees: 'eq' in: highest.
ObjectMemory quit.
].

(action = 'total' or: [action = 'avg'])
  ifTrue: [
    total := 0.
    index := 1.
    list := runcode getRoster. "gets roster"
    [index <= list size] "iterate"
    whileTrue: [
    amount := ((list at: index) getEarning). "get the amount"
    ((runcode check: amount use: op in: threshold) = 1)
    ifTrue:[total := total + amount.].
    index := index + 1.
    ]. "end of iteration"
    (action = 'total')
    ifTrue: [
    'Total payment is $' display.
    total displayNl.
    ObjectMemory quit.
  ].

    (action = 'avg')
    ifTrue: [
      'Average payment is $' display.
      (((total/tally) asFloat) asScaledDecimal: 2) displayNl.
      ObjectMemory quit.
    ].
].
'Invalid action: ' display.
action displayNl.
'Valid actions: print count min max sum avg' displayNl.
ObjectMemory quit.
