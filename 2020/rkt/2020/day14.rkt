#lang racket

(define (part-a data)
  (define (apply-mask mask value)
    (cond [(null? mask) 0]
          [(eq? #\0 (car mask))
           (* 2 (apply-mask (cdr mask) (quotient value 2)))]
          [(eq? #\1 (car mask))
           (+ 1 (* 2 (apply-mask (cdr mask) (quotient value 2))))]
          [else
           (+ (modulo value 2)
              (* 2 (apply-mask (cdr mask) (quotient value 2))))]))
  
  (let-values
      ([(mem mask)
        (for/fold ([mem (make-hash)]
                   [mask null])
                  ([line (string-split data "\n")])
          (if (string-prefix? line "mask =")
              (values mem
                      (reverse (string->list
                                (cadr (regexp-match #px"mask = (\\w+)" line)))))
              (let* [(match (regexp-match #px"mem\\[(\\d+)\\] = (\\d+)" line))
                     (addr (string->number (cadr match)))
                     (value (apply-mask mask (string->number (caddr match))))]
                (begin
                  (hash-set! mem addr value)
                  (values mem mask)))))])
    (apply + (hash-values mem))))

(define (part-b data)
  (define (mask->addresses mask n)
    (cond [(null? mask) '(0)]
          [(eq? (car mask) #\0)
           (for/list ([address (mask->addresses (cdr mask) (quotient n 2))])
             (+ (* 2 address)
                (modulo n 2)))]
          [(eq? (car mask) #\1)
           (for/list ([address (mask->addresses (cdr mask) (quotient n 2))])
             (+ (* 2 address) 1))]
          [(eq? (car mask) #\X)
           (let [(addresses (mask->addresses (cdr mask) (quotient n 2)))]
             (flatten
              (for/list ([address addresses])
                (list (+ (* 2 address) 1)
                      (* 2 address)))))]
          [else (error "Unknown bit --" (car mask))]))
  
  (let-values
      ([(mem mask)
        ; Can probably abstract this for/fold to a function
        ; which accepts the data and a `mem[x] = y` predicate
        (for/fold ([mem (make-hash)]
                   [mask null])
                  ([line (string-split data "\n")])
          (if (string-prefix? line "mask =")
              (values mem
                      (reverse (string->list
                                (cadr (regexp-match #px"mask = (\\w+)" line)))))
              (let* [(match (regexp-match #px"mem\\[(\\d+)\\] = (\\d+)" line))
                     (addrs (mask->addresses mask (string->number (cadr match))))
                     (value (string->number (caddr match)))]
                (begin
                  (for ([addr addrs])
                    (hash-set! mem addr value))
                  (values mem mask)))))])
    (apply + (hash-values mem))))
