#lang racket

(require megaparsack megaparsack/text data/monad data/applicative data/either)

(define (char->op c)
  (if (eq? #\+ c) + *))

; (2 (#\+ 5) (#\+ 7)) => 14
(define (eval-expr expr)
  (for/fold ([result (if (list? (car expr))
                         (eval-expr (car expr))
                         (car expr))])
            ([term (cdr expr)])
    (let [(op (char->op (car term)))
          (right (cadr term))]
      (op result
          (if (list? right)
              (eval-expr right)
              right)))))

(define (part-a data)
  (define (line->expr line)
    ; term := number | (expr)
    (define term/p
      (or/p integer/p
            (do (char/p #\()
              (inner <- expression/p)
              (char/p #\))
              (pure inner))))

    ; expr := term ('+'|'*' term)*
    (define expression/p
      (do (first <- term/p)
        (rest <- (many/p
                  (do space/p
                    (op <- (or/p (char/p #\+) (char/p #\*)))
                    space/p
                    (term <- term/p)
                    (pure (list op term)))))
        (pure (cons first rest))))

    (parse-result! (parse-string expression/p line)))

  (for/sum ([line (string-split data "\n")])
    (eval-expr (line->expr line))))

(define (part-b data)
  (define (line->expr line)
    ; term := number | (expr)
    (define term/p
      (or/p integer/p
            (do (char/p #\()
              (inner <- expression/p)
              (char/p #\))
              (pure inner))))

    ; add := term ('+' term)*
    (define add/p
      (do (first <- term/p)
        (rest <- (many/p
                  ; Hmmm need a try here?
                  (try/p
                   (do space/p
                     (char/p #\+)
                     space/p
                     (term <- term/p)
                     (pure (list #\+ term))))))
        (pure (cons first rest))))

    ; mul := add ('*' add)*
    (define mul/p
      (do (first <- add/p)
        (rest <- (many/p
                  (do space/p
                    (char/p #\*)
                    space/p
                    (term <- add/p)
                    (pure (list #\* term)))))
        (pure (cons first rest))))

    ; expr := mul | add
    (define expression/p
      (or/p (try/p mul/p) add/p))

    (parse-result! (parse-string expression/p line)))

  (for/sum ([line (string-split data "\n")])
    (eval-expr (line->expr line))))
