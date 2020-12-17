#lang racket

(define (make-grid) (mutable-set))
(define (grid-set-active! grid pos)
  (set-add! grid pos))
(define (grid-active? grid pos) (set-member? grid pos))

(define (active-neighbors get-neighbors grid pos)
  (for/sum ([pos (get-neighbors grid pos)])
    (if (grid-active? grid pos) 1 0)))

(define (next-state get-neighbors grid)
  (let [(cells-to-check
         (for/fold ([result (set-copy grid)])
                   ([pos grid])
           (begin
             (set-union! result (get-neighbors grid pos))
             result)))]
    (for/set
        ([pos cells-to-check]
         #:when (let [(num-active-neighbors
                       (active-neighbors get-neighbors grid pos))]
                  (or (and (grid-active? grid pos)
                           (or (= 2 num-active-neighbors)
                               (= 3 num-active-neighbors)))
                      (and (not (grid-active? grid pos))
                           (= 3 num-active-neighbors)))))
      pos)))

(define (data->grid data dimensions)
  (let [(grid (make-grid))
        (lines (string-split data "\n"))
        (padding (for/list ([k (in-range (- dimensions 2))]) 0))]
    (begin
      (for ([line lines]
            [i (in-range (length lines))])
        (for ([char (string->list line)]
              [j (in-range (string-length line))]
              #:when (eq? #\# char))
          (grid-set-active! grid (append (list i j) padding))))
      grid)))

(define (part-a data)
  (define (get-neighbors grid pos)
    (let [(x (car pos))
          (y (cadr pos))
          (z (caddr pos))]
      (for/set ([pos
                 (cartesian-product (list (- x 1) x (+ x 1))
                                    (list (- y 1) y (+ y 1))
                                    (list (- z 1) z (+ z 1)))]
                #:when (not (equal? pos (list x y z))))
        pos)))
  
  (set-count
   (for/fold ([grid (data->grid data 3)])
             ([i (in-range 6)])
     (next-state get-neighbors grid))))

(define (part-b data)
  (define (get-neighbors grid pos)
    (let [(x (car pos))
          (y (cadr pos))
          (z (caddr pos))
          (w (cadddr pos))]
      (for/set ([pos
                 (cartesian-product (list (- x 1) x (+ x 1))
                                    (list (- y 1) y (+ y 1))
                                    (list (- z 1) z (+ z 1))
                                    (list (- w 1) w (+ w 1)))]
                #:when (not (equal? pos (list x y z w))))
        pos)))
  
  (set-count
   (for/fold ([grid (data->grid data 4)])
             ([i (in-range 6)])
     (next-state get-neighbors grid))))

