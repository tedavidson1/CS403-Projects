Employee subclass: Salaried [
  | weeklySalary |
"cleared a compile with no syntax errors"
  init [
    <category: 'initialization'>
    weeklySalary := 0.00.
    ^ super init "calls the super class initialization"
  ]

  setSalary: amount [
    <category: 'handling salary'>
    weeklySalary := amount
  ]

  getSalary [
    <category: 'handling salary'>
    | money |
    money := weeklySalary.
    ^money
  ]

  getEarning [
    <category: 'finds earnings'>
    | earnings |
    earnings := weeklySalary.
    ^earnings
  ]

  getInfo [
    <category: 'info'>
    'Salaried employee: ' display.
    super getInfo.
    'weekly salary: ' display.
    self getSalary displayNl
  ]
] "end of class"
