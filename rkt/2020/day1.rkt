#lang racket

(define sample-data
  '(1721
    979
    366
    299
    675
    1456))

(define (get-pairs ls)
  (if (null? ls)
      '()
      (append
       (map (λ (second)
              (cons (car ls) second))
            (cdr ls))
       (get-pairs (cdr ls)))))

(define (part-a data)
  (car (map (λ (pair) (* (car pair) (cdr pair)))
            (filter (λ (pair)
                      (= 2020 (+ (car pair)
                                 (cdr pair))))
                    (get-pairs data)))))

(define (get-trios ls)
  (if (null? ls)
      '()
      (append
       (map (λ (pair) (cons (car ls) pair))
            (get-pairs (cdr ls)))
       (get-trios (cdr ls)))))

(define (part-b data)
  (car (map (λ (trio) (* (car trio) (cadr trio) (cddr trio)))
            (filter (λ (trio)
                      (= 2020
                         (+ (car trio) (cadr trio) (cddr trio))))
                    (get-trios data)))))
