#lang racket

(define (data->ls data)
  (for/list ([line (string-split data "\n")])
    (string->list line)))

(define (fix next-fn chart)
  (let [(next (next-fn chart))]
    (if (equal? next chart)
        chart
        (fix next-fn next))))

(define (part-a data)
  (define (count-neighbors chart r c)
    (for/sum ([dx '(-1 0 1)])
      (for/sum ([dy '(-1 0 1)])
        (cond [(and (= 0 dx) (= 0 dy))
               0]
              [(or (< (+ r dy) 0) (>= (+ r dy) (length chart)))
               0]
              [(or (< (+ c dx) 0) (>= (+ c dx) (length (car chart))))
               0]
              [(eq? #\# (list-ref (list-ref chart (+ r dy)) (+ c dx)))
               1]
              [else 0]))))

  (define (next-state chart)
    (for/list ([r (in-range (length chart))])
      (for/list ([c (in-range (length (car chart)))])
        (let [(seat (list-ref (list-ref chart r) c))]
          (cond [(and (eq? seat #\L) (= (count-neighbors chart r c) 0))
                 #\#]
                [(and (eq? seat #\#) (>= (count-neighbors chart r c) 4))
                 #\L]
                [else seat])))))

  (for/sum ([row (fix next-state (data->ls data))])
    (for/sum ([seat row])
      (if (eq? seat #\#)
          1
          0))))

(define (part-b data)
  (define (first-seat-seen chart r c dy dx)
    (cond [(or (< (+ r dy) 0) (>= (+ r dy) (length chart)))
           #f]
          [(or (< (+ c dx) 0) (>= (+ c dx) (length (car chart))))
           #f]
          [else
           (let [(seat (list-ref (list-ref chart (+ r dy)) (+ c dx)))]
             (if (or (eq? seat #\#) (eq? seat #\L))
                 seat
                 (first-seat-seen chart (+ r dy) (+ c dx) dy dx)))]))

  (define (count-neighbors chart r c)
    (for/sum ([d '((-1 -1) (-1 0) (-1 1)
                           (0 -1) (0 1) 
                           (1 -1) (1 0) (1 1))])
      (if (eq? #\# (first-seat-seen chart r c (car d) (cadr d)))
          1
          0)))

  (define (next-state chart)    
    (for/list ([r (in-range (length chart))])
      (for/list ([c (in-range (length (car chart)))])
        (let [(seat (list-ref (list-ref chart r) c))]
          (cond [(and (eq? seat #\L) (= (count-neighbors chart r c) 0))
                 #\#]
                [(and (eq? seat #\#) (>= (count-neighbors chart r c) 5))
                 #\L]
                [else seat])))))
  
  (for/sum ([row (fix next-state (data->ls data))])
    (for/sum ([seat row])
      (if (eq? seat #\#)
          1
          0))))