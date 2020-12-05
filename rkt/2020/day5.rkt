#lang racket

(define (seat-id pattern)
  (define (bisect pattern a b lower-char)
    (if (= a b)
        a
        (let [(avg (quotient (+ a b) 2))]
          (if (equal? (string-ref pattern 0) lower-char)
              (bisect (substring pattern 1) a avg lower-char)
              (bisect (substring pattern 1) (+ avg 1) b lower-char)))))

  (let [(row (bisect (substring pattern 0 7) 0 127 #\F))
        (col (bisect (substring pattern 7 10) 0 7 #\L))]
    (+ (* 8 row) col)))

(define (part-a data)
  (foldl (λ (line acc)
           (max acc (seat-id line)))
         0
         (string-split data "\n")))

(define (part-b data)
  (define (first-missing ls)
    (cond [(< (length ls) 2) #f]   ; no missing item
          [(> (- (cadr ls) (car ls)) 1)  ; the items are not consecutive!
           (+ (car ls) 1)]               ; return the one missing
          [else (first-missing (cdr ls))]))

  (let* [(seat-ids (map seat-id (string-split data "\n")))
         (sorted-seat-ids (sort seat-ids <))]
    (first-missing sorted-seat-ids)))

