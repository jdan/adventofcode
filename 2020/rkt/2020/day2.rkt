#lang racket

(require megaparsack megaparsack/text data/monad data/applicative)

(struct rule (min max letter) #:transparent)

(define line/p
  (do (min <- integer/p)
    (char/p #\-)
    (max <- integer/p)
    space/p
    (letter <- letter/p)
    (char/p #\:)
    space/p
    (input <- (many/p letter/p))
    (pure (cons (rule min max letter)
                input))))

(define (parse-line line)
  (parse-result!
   (parse-string line/p line)))

(define (valid/a? line)
  (let* [(result (parse-line line))
         (rul (car result))
         (input (cdr result))
         (count (length (filter (λ (char)
                                  (eq? char (rule-letter rul)))
                                input)))]
    (and (>= count (rule-min rul))
         (<= count (rule-max rul)))))

(define (part-a input-string)
  (length
   (filter valid/a?
           (string-split input-string "\n"))))

(define sample-data
  "1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc")

(define (valid/b? line)
  (let* [(result (parse-line line))
         (rul (car result))
         (letter (rule-letter rul))
         ; for part b, "min" and "max" are actually two position
         (pos1 (rule-min rul))
         (pos2 (rule-max rul))
         (input (cdr result))]  
    (xor (eq? letter (list-ref input (- pos1 1)))
         (eq? letter (list-ref input (- pos2 1))))))

(define (part-b input-string)
  (length
   (filter valid/b?
           (string-split input-string "\n"))))
