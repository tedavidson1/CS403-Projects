Employee subclass: Hourly [
  | hours hourlyRate |
"Compiles properly"
  init [
    <category: 'initialization'>
    hours := 0.00.
    hourlyRate := 0.00.
    ^ super init "calls the super class initialization"
  ]

  setHours: time [
    <category: 'handling hours'>
    hours := time
  ]

  getHours [
    <category: 'handling hours'>
    | time |
    time := hours.
    ^time
  ]

  setRate: rate [
    <category: 'handling hourly rate'>
    hourlyRate := rate
  ]

  getRate [
    <category: 'handling hourly rate'>
    | rate |
    rate := hourlyRate.
    ^rate
  ]

  getEarning [
    <category: 'finds earnings'>
    | earnings |
    (hours <= 40)
      ifTrue: [earnings := (hours * hourlyRate).]
      ifFalse: [ (hours <= 50)
          ifTrue: [earnings := ((40 * hourlyRate) + ((hours - 40) * (hourlyRate * 1.5))).]
          ifFalse: [earnings := ((40 * hourlyRate) + (10 * (hourlyRate * 1.5)) + ((hours - 50) * (hourlyRate * 2))).].
      ]. "ends the false block"
      ^earnings
  ]

  getInfo [
    <category: 'info'>
    'Hourly employee: ' display.
    super getInfo.
    'hours worked: ' display.
    self getHours display.
    ', hourly rate: ' display.
    self getRate displayNl
  ]
]"end of class"
