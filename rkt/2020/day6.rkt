#lang racket

(define (count-yesses answers op)
  (let [(answer-sets (map (λ (line)
                            (list->set (string->list line)))
                          (string-split answers "\n")))]
    (set-count
     (foldl op
            (car answer-sets)
            answer-sets))))

(define (groups->total data op)
  (foldl (λ (group sum) (+ sum (count-yesses group op)))
         0
         (string-split data "\n\n")))

(define (part-a data) (groups->total data set-union))
(define (part-b data) (groups->total data set-intersect))