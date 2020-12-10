#lang racket

(require memoize)

(define (data->ls data)
  (let [(sorted
         (sort (for/list ([line (string-split data "\n")])
                 (string->number line))
               <))]
    (append (list 0)
            sorted
            (list (+ 3 (last sorted))))))

(define (mult-differences ls)
  (define (inner ls ones threes last)
    (cond [(null? ls) (* ones threes)]
          [(= 1 (- (car ls) last))
           (inner (cdr ls) (+ ones 1) threes (car ls))]
          [(= 3 (- (car ls) last))
           (inner (cdr ls) ones (+ threes 1) (car ls))]
          [else
           (inner (cdr ls) ones threes (car ls))]))

  (inner (cdr ls) 0 0 (car ls)))

(define (part-a data)
  (mult-differences (data->ls data)))

(define (arrangements ls)
  (define/memo (inner last ls terminal)
    (cond [(null? ls)
           ; The final adapter could not have been dropped
           (if (< (- terminal last) 3)
               1
               0)]
          [(> (- (car ls) last) 3) 0]
          [else
           (+ (inner (car ls) (cdr ls) terminal)
              (inner last (cdr ls) terminal))]))
  (inner (car ls) (cdr ls) (last ls)))

(define (part-b data)
  (arrangements (data->ls data)))