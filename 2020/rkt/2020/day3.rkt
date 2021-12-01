#lang racket

(define (traverse terrain speed-x speed-y)
  (define (inner terrain x-coord)
    (if (null? terrain)
        0
        (let [(index
               (modulo x-coord (string-length (car terrain))))]
          (+ (if (eq? #\# (string-ref (car terrain) index))
                 1
                 0)
             (inner (drop terrain (min (length terrain) speed-y))
                    (+ speed-x x-coord))))))
  (inner (string-split terrain "\n") 0))

(define (part-a terrain)
  (traverse terrain 3 1))

(define (part-b terrain)
  (foldl
   (λ (pair acc)
     (* acc (traverse terrain (car pair) (cadr pair))))
   1
   '((1 1)
     (3 1)
     (5 1)
     (7 1)
     (1 2))))
  
