#lang racket

(struct tile (id pattern top right bottom left) #:mutable #:transparent)
(define (make-tile id lines)
  (tile id
        (for/vector ([line lines])
          (list->vector (string->list line)))
        null null null null))

(define (data->hash data)
  (for/fold ([tiles (make-hash)])
            ([entry (string-split data "\n\n")])
    (let* [(lines (string-split entry "\n"))
           (id (string->number
                (cadr (regexp-match #px"Tile (\\d+):" (car lines)))))
           (tile (make-tile id (cdr lines)))]
      (begin
        (hash-set! tiles id tile)
        tiles))))

(define (get-side tile side)
  (let [(pattern (tile-pattern tile))]
    (cond [(eq? side 'top)
           (vector-ref pattern 0)]
          [(eq? side 'bottom)
           (vector-ref pattern (- (vector-length pattern) 1))]
          [(eq? side 'left)
           (for/vector ([row pattern])
             (vector-ref row 0))]
          [(eq? side 'right)
           (for/vector ([row pattern])
             (vector-ref row (- (vector-length row) 1)))]
          [else (error "Unknwon side --" side)])))

(define (fits? source side candidate)
  (define (side=? a b)
    (or (equal? a b)
        (equal? a (list->vector (reverse (vector->list b))))))
  
  (let [(source-side (get-side source side))]
    (for/or ([dir '(top right bottom left)])
      (side=? source-side (get-side candidate dir)))))
    

(define (set-adjacencies! hash)
  (for ([i (hash-values hash)])
    (for ([j (hash-values hash)]
          #:when (not (= (tile-id i) (tile-id j))))
      (cond [(fits? i 'top j)
             (set-tile-top! i (tile-id j))]
            [(fits? i 'right j)
             (set-tile-right! i (tile-id j))]
            [(fits? i 'bottom j)
             (set-tile-bottom! i (tile-id j))]
            [(fits? i 'left j)
             (set-tile-left! i (tile-id j))]))))

(define (part-a data)
  (define (count-neighbors tile)
    (+ (if (null? (tile-top tile)) 0 1)
       (if (null? (tile-right tile)) 0 1)
       (if (null? (tile-bottom tile)) 0 1)
       (if (null? (tile-left tile)) 0 1)))
  
  (let ([tiles (data->hash data)])
    (set-adjacencies! tiles)
    (for/product ([tile (hash-values tiles)]
                  #:when (= 2 (count-neighbors tile)))
      (tile-id tile))))