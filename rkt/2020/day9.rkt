#lang racket

(require memoize)

(define (data->ls data)
  (for/list ([line (string-split data "\n")])
    (string->number line)))

(define (first-not-sum ls preamble-length)
  (define (inner ls available)
    (if (null? ls)
        #f
        (let [(available-sums
               (for/list ([pair (cartesian-product available available)])
                 (apply + pair)))]
          (if (member (car ls) available-sums)
              (inner (cdr ls) (append (cdr available) (list (car ls))))
              (car ls)))))
  (inner (drop ls preamble-length) (take ls preamble-length)))

(define (part-a data)
  (first-not-sum (data->ls data) 25))

(define (find-contiguous-summing n ls)
  (define/memo (inner taking ls)
    (cond [(empty? ls) #f]
          [(> taking (length ls)) #f]
          [(= n (apply + (take ls taking))) (take ls taking)]
          [else
           ; Divide-and-conquer... let's memoize
           (or (inner (+ taking 1) ls)
               (inner taking (cdr ls)))]))

  (inner 2 ls))

(define (part-b data)
  (let* [(invalid-number (part-a data))
         (seq (find-contiguous-summing invalid-number (data->ls data)))]
    (+ (apply min seq)
       (apply max seq))))