Object subclass: Employee [
  | firstName lastName |
"cleared a compile with no syntax errors"
  Employee class >> new [
    <category: 'instance creation'>
    | r |
    r := super new.
    r init.
    ^r
  ]

  init [
    <category: 'initialization'>
    firstName := 'none'.
    lastName := 'none'
  ]

  setLast: last [
    <category: 'handling last name'>
    lastName := last
  ]

  getLast [
    <category: 'handling last name'>
    | last | "blue bars means temp var"
    last := lastName.
    ^last
  ]

  setFirst: first [
    <category: 'handling first name'>
    firstName := first
  ]

  getFirst [
    <category: 'handling first name'>
    | first |
    first := firstName.
    ^first
  ]

  getInfo [
    <category: 'info'>
    "may need to specify sub in here?"
    firstName display.
    ' ' display.
    lastName displayNl.
  ]

]"end of class"
