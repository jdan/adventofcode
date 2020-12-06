#lang racket

(define (total-yesses answers)
  (length (remove-duplicates
           (string->list
            (apply string-append (string-split answers "\n"))))))

(define (part-a data)
  (foldl (λ (group sum) (+ sum (total-yesses group)))
         0
         (string-split data "\n\n")))

(define (shared-yesses answers)
  (let [(answer-sets (map (λ (line)
                            (list->set (string->list line)))
                          (string-split answers "\n")))]
    (set-count
     (foldl set-intersect
            (car answer-sets)
            answer-sets))))

(define (part-b data)
  (foldl (λ (group sum) (+ sum (shared-yesses group)))
         0
         (string-split data "\n\n")))