#lang racket

(define (nth-spoken data ask)
  (define (data->ls data)
    (map string->number (string-split data ",")))

  (define seen-before? cadr)
  (define (update-history! hash n turn)
    (hash-update! hash
                  n
                  (λ (history) (take (cons turn history) 2))
                  (λ () (list turn #f))))
  
  (let* [(ns (data->ls data))
         (spoken-history
          (make-hash (for/list ([n ns]
                                [turn (in-range 1 (+ (length ns) 1))])
                       (cons n (list turn #f)))))]

    (for/fold ([last-n (last ns)])
              ([turn (in-range (+ 1 (length ns)) (+ ask 1))])
      (let [(history (hash-ref spoken-history last-n))]
        (if (seen-before? history)
            (let [(difference (- (car history) (cadr history)))]
              (begin
                (update-history! spoken-history difference turn)
                difference))
            (begin
              (update-history! spoken-history 0 turn)
              0))))))

(define (part-a data)
  (nth-spoken data 2020))

; cpu time: 38062 real time: 38062 gc time: 22628
(define (part-b data)
  (nth-spoken data 30000000))