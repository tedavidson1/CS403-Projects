Employee subclass: Commission [
  | minSalary numSold percent |
"compiles correctly"
  init [
    <category: 'initialization'>
    minSalary := 00.00.
    numSold := 0.
    percent := 00.00.
    ^ super init "calls the super class initialization"
  ]

  setminSalary: amount [
    <category: 'handling minSalary'>
    minSalary := amount
  ]

  getminSalary [
    <category: 'handling minSalary'>
    | money |
    money := minSalary.
    ^money
  ]

  setnumSold: amount [
    <category: 'handling numSold'>
    numSold := amount
  ]

  getnumSold [
    <category: 'handling numSold'>
    | total |
    total := numSold.
    ^total
  ]

  setPercent: rate [
    <category: 'handling percent'>
    percent := rate
  ]

  getPercent [
    <category: 'handling percent'>
    | rate |
    rate := percent.
    ^rate
  ]

  getEarning [
    <category: 'finds earnings'>
    | value|
    value := numSold * percent.
    (value > minSalary)
      ifTrue: [^value]
      ifFalse: [^minSalary].
  ]

  getInfo [
    <category: 'info'>
    | temp |
    'Commission employee: ' display.
    super getInfo.
    'minimum salary: ' display.
    self getminSalary display.
    ', sales amount: ' display.
    self getnumSold display.
    ', commission rate: ' display.
    temp := (self getPercent) * 100.
    temp display.
    '%' displayNl.
  ]
] "end of class"
