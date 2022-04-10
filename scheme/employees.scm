(define (example)
  (list (list "salaried" "Jeremy" "Greer" "1800")
        (list "hourly" "Maria" "Garcia" "25" "8.50")
        (list "commission" "Floyd" "Jenkins" "300" "3000" ".08")
        (list "hourly" "Carlton" "West" "45" "12.50")
        (list "commission" "Rose" "Harvey" "300" "15000" ".15")
        (list "hourly" "Viola" "Jennings" "65" "17.50")
        (list "salaried" "Robert" "Johnson" "2700")
        ))

(define (print-file name)
    (print-file-helper (open-input-file name)))

(define (print-file-helper port)
  (let ((stuff (read-line port)))
  ;(display stuff)(newline)
    (cond
        ((eof-object? stuff) '()) ;return empty list, no more to do
        (else (cons (str-split stuff) (print-file-helper port)))
        ;combines the list from parsing the line with the next call
    )));end of if, let, and function



(define (str-split-helper line str list)
    (cond
        ((string-null? line)
            (if (string-null? str)
		(reverse list)
		(reverse (cons str list))))
        ((char=? (string-ref line 0) #\space)
            (if (string-null? str)
                (str-split-helper (string-tail line 1) str list)
                (str-split-helper (string-tail line 1) "" (cons str list))))
        (else
            (str-split-helper (string-tail line 1)
                              (string-append str (string-head line 1))
                              list))))

(define (str-split line) (str-split-helper line "" '()))
;;;;helper to recursively compute hourly earnings
(define (get-hourly-earning-helper hours wage)
  (cond
  ((<= hours 40) (* hours wage)) ;may need to be changed
  ((<= hours 50) (+ (* 1 (* wage 1.5)) (get-hourly-earning-helper (- hours 1) wage)))
  (else (+ (* 1 (* wage 2)) (get-hourly-earning-helper (- hours 1) wage)))));over 50

;;;;gets hourly earnings
(define (get-hourly-earning person)
  (get-hourly-earning-helper (string->number (list-ref person 3)) (string->number (list-ref person 4))))
;;;;gets salaried earnings
(define (get-salaried-earnings person) (string->number (list-ref person 3)))
;;;;gets commission earnings
(define (get-commission-earning person)
  (let (
        (x (string->number (list-ref person 3)));end of x dec
        (com (* (string->number(list-ref person 4)) (string->number(list-ref person 5))) );end of com dec
        );end of variable decs
    (if (> x com) x com)))
;function to convert to a readable percent
(define (percent-convertor percent)
  (* (string->number percent) 100))
;;;;print hourly
(define (print-hourly person)
    (display "Hourly employee: ")
    (display (list-ref person 1))
    (display " ")
    (display (list-ref person 2))
    (newline)
    (display "hours worked: ")
    (display (list-ref person 3))
    (display ", hourly rate: ")
    (display (list-ref person 4))
    (newline)
    (display "earned: $")
    (display (get-hourly-earning person))
    (newline)
    (newline)
    );end of function
;;;;print salary
(define (print-salary person)
    (display "Salaried employee: ")
    (display (list-ref person 1))
    (display " ")
    (display (list-ref person 2))
    (newline)
    (display "weekly salary: ")
    (display (list-ref person 3))
    (newline)
    (display "earned: $")
    (display ( list-ref person 3))
    (newline)
    (newline)
    );end of function
;;;;prints commission
(define (print-commission person)
    (display "Commission employee: ")
    (display (list-ref person 1))
    (display " ")
    (display (list-ref person 2))
    (newline)
    (display "minimum salary: ")
    (display (list-ref person 3))
    (display ", sales amount: ")
    (display (list-ref person 4))
    (display ", commission rate: ")
    (display (percent-convertor(list-ref person 5))) ;special case that needs to be made a number x 100
    (display "%")
    (newline)
    (display "earned: $")
    (display (get-commission-earning person))
    (newline)
    (newline)
    );end of function
;;;;wrapper for printing each type
(define (print-info person) ;function to call functions to print info of person
  (cond
    ((equal? "hourly" (car person)) (print-hourly person))
    ((equal? "salaried" (car person)) (print-salary person))
    (else (print-commission person))))
;;;;prints action list
(define (print-valid-actions) ;made a separate function for use case of invalid action
    (display "Valid actions: count print min max total avg")
    (newline)
    )
;;;;print valid operators
(define (print-usage-commands)
    (print-valid-actions)
    (display "Valid operators: eq ne gt ge lt le")
    (newline)
    (newline)
    )
;;;;prints general usage
(define (print-usage)
  (display "Usage: (perform employee_file action)")
  (newline)
  (display "or")
  (newline)
  (display "Usage: (perform employee_file action operator threshold)")
  (newline)
  (newline)
  (print-usage-commands)
  )
;;;;print invalid action
(define (print-invalid input) (display "Invalid action: ") (display input) (newline) (print-valid-actions))
;;;;Prints the case of no employees satisfying a condition
(define (print-none)
  (display "There are no employees satisfied the specified condition.")
  (newline)
  (newline))
;;;;stores the list of valid actions
(define (action-list)(list "count" "print" "min" "max" "total" "avg"));list of valid actions
;;;;Checks if the action is in the list
(define (check-action input valid)
  (cond
    ((null? valid) #f)
    ((equal? input (car valid)) #t)
    (else (check-action input (cdr valid)))))

;;;;wrapper for getting the earning of a person. Calls correct function from here
(define (get-earning person)
  (cond
    ((equal? "hourly" (car person)) (get-hourly-earning person)) ;calls function and helper
    ((equal? "salaried" (car person)) (string->number (list-ref person 3)));already have it
    (else (get-commission-earning person)) ;gets commissions earning
    ));end of cond
;;;;Function that gives the valid threshold of the code
(define (threshold args)
  (cond
    ((equal? 2 (length args)) 0)
    (else (list-ref args 3)))) ;was a convert frm string to number

;;;;function that returns the operator for the string as a string
(define (operator args)
  (cond
    ((equal? 2 (length args)) >=)
    ((equal? "eq" (list-ref args 2)) =)
    ((equal? "ne" (list-ref args 2)) not-equal)
    ((equal? "ge" (list-ref args 2)) >=)
    ((equal? "le" (list-ref args 2)) <=)
    ((equal? "gt" (list-ref args 2)) >)
    ((equal? "lt" (list-ref args 2)) <)
    (else #f)))
;;;;Own function that does true or false on two things
(define (not-equal a b)
  (if (not(= a b)) #t #f))

;;;;Function to print how many left in list
(define (count survivors)
  (cond
    ((zero? (length survivors)) (print-none))
    (else (begin
    (display "There are ")
    (display (length survivors))
    (display " employees")
    (newline)
    (newline)))))
;;;;Function that gives the string passed to it as code
(define (word select) (string->symbol select))
;;;;function to show how the printing the filtered list works
(define (print survivors)
  (cond
    ((null? survivors) (print-none))
    (else (map print-info survivors))
  ))
;;;;Finds average of the data
(define (avg survivors)
  ;;call get earning on everyone and sum it. Divide it by number of survivors then
  (display "Average payment per employee is $")
  (display (/ (apply + (map get-earning survivors)) (length survivors)))
  (newline)(newline))
;;;;Function to output the total of each employee
(define (total survivors)
  (display "Total payment is $")
  (display (apply + (map get-earning survivors)))
  (newline) (newline))
;;;gets the max of a list of people
(define (get-max people)
  (apply max(map get-earning people)))
;;;;gets the min of a list of people
(define (get-min people)
  (apply min(map get-earning people)))
;;;;;;;;The main method of the program;;;;;;;;;;;;;;
(define (perform . args)
  (cond
    ((and (not (equal? (length args) 2)) (not (equal? (length args) 4))) (print-usage)) ;if improper args
    ((eq? #f (check-action (list-ref args 1) (action-list))) (print-invalid (list-ref args 1)));if false, output the invalid action part
    (else
    (let ((roster (print-file (list-ref args 0))) (b (operator args)) (c (threshold args))) ;roster holds the result of calling for the built list
    (begin ;start the block for only the proper output
    ( let ((d (filter (lambda (x) (b (get-earning x) c)) roster)))
      (cond
        ((eq? #f b) (print-none))
        ((equal? "max" (list-ref args 1)) (print (filter (lambda (y) (= (get-earning y) (get-max d))) d)))
        ((equal? "min" (list-ref args 1)) (print (filter (lambda (y) (= (get-earning y) (get-min d))) d)))
        (else
          (cond
            ((equal? "count" (list-ref args 1)) (count d))
            ((equal? "print" (list-ref args 1)) (print d))
            ((equal? "total" (list-ref args 1)) (total d))
            (else (avg d))
          );end of inner cond
        ); end of else
      );end of outer cond
    ); end of filtered list let
    );end of begin
    );end of let
    )));end of else cond and def
