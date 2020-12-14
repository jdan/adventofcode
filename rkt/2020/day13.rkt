#lang racket

(define (part-a data)
  (define make-input cons)
  (define input-time car)
  (define input-schedules cdr)

  (define (data->input data)
    (let [(lines (string-split data "\n"))]
      (make-input (string->number (car lines))
                  (for/list ([item (string-split (cadr lines) ",")]
                             #:when (not (equal? item "x")))
                    (string->number item)))))
  
  (let* [(input (data->input data))
         (best-schedule-and-wait
          (for/fold ([best (cons 0 +inf.0)])
                    ([schedule (input-schedules input)])
            (let ([wait (- schedule
                           (modulo (input-time input) schedule))])
              (if (< wait (cdr best))
                  (cons schedule wait)
                  best))))]
    (* (car best-schedule-and-wait)
       (cdr best-schedule-and-wait))))

; e.g. 17,x,13,19
;
; n = 17*a
; n + 2 = 13*b
; n + 3 = 19*c
;
; n =  0 (mod 17)
; n = -2 (mod 13)
; n = -3 (mod 19)
;
; We'll use the Chinese Remainder theorem to find n
; (but I'm not going to write it myself)

; https://docs.racket-lang.org/math/number-theory.html
(require math/number-theory)

(define (part-b data)
  (define (data->input data)
    (let* [(lines (string-split data "\n"))
           (ns (string-split (cadr lines) ","))]
      (for/lists (as ns #:result (list as ns))
                 ([n ns]
                  [a (in-range (length ns))]
                  #:when (not (equal? "x" n)))
        (values (- a)
                (string->number n)))))

  (apply solve-chinese (data->input data)))
