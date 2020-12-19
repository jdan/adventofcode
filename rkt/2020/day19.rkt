#lang racket

(require memoize)

(define (rules->hash data)
  (let ([hash (make-hash)])
    (for ([line (string-split data "\n")])
      (let* [(parts (string-split line ": "))
             (key (string->number (car parts)))
             (trimmed (cadr parts))]
        (hash-set!
         hash key
         (cond [(and (string-prefix? trimmed "\"")
                     (string-suffix? trimmed "\""))
                (substring trimmed 1 (- (string-length trimmed) 1))]
               [(string-contains? trimmed "|")
                (cons 'or (for/list ([part (string-split trimmed " | ")])
                            (map string->number (string-split part " "))))]
               [else (map string->number (string-split trimmed " "))]))))
    hash))

(define/memo (get-regexp-str hash key)
  (let [(lookup (hash-ref hash key))]
    (cond [(string? lookup)
           (regexp-quote lookup)]
          [(eq? 'or (car lookup))
           (let [(groups
                  (for/list ([group (cdr lookup)])
                    ; Can probably abstract this for/fold since we use
                    ; it in the `else` too
                    (for/fold ([acc ""])
                              ([entry group])
                      (string-append acc (get-regexp-str hash entry)))))]
             (string-append "("
                            (string-join groups "|")
                            ")"))]
          [else
           (for/fold ([acc ""])
                     ([entry lookup])
             (string-append acc (get-regexp-str hash entry)))])))

(define (get-regexp hash key)
  (regexp (string-append "^"
                         (get-regexp-str hash key)
                         "$")))

(define (part-a data)
  (let* [(split (string-split data "\n\n"))
         (pre (get-regexp (rules->hash (car split)) 0))]
    (for/sum ([line (string-split (cadr split) "\n")])
      (if (regexp-match? pre line) 1 0))))

(define (part-b data)
  (define (munge-hash hash)
    ; The following rules
    ;   8: 42
    ;   11: 42 31
    ; have become
    ;   8: 42 | 42 8
    ;   11: 42 31 | 42 11 31
    ;
    ; We'll expand the regex a ~sufficient amount to cover our
    ; input data

    (let [(LIMIT 5)]
      ; 8: 42 | 42 8
      ; => 8: 42 | 42 42 | 42 42 42 | 42 42 42 42 ...
      (hash-set!
       hash 8
       (cons 'or
             (for/list ([i (in-range LIMIT)])
               (for/list ([j (in-range (+ i 1))]) 42))))

      ; 11: 42 31 | 42 11 31
      ; => 11: 42 31 | 42 42 31 31 | 42 42 42 31 31 31 | ...
      (hash-set!
       hash 11
       (cons 'or
             (for/list ([i (in-range LIMIT)])
               (append (for/list ([j (in-range (+ i 1))]) 42)
                       (for/list ([j (in-range (+ i 1))]) 31)))))

      hash))

  ; Racket has a (very low) size limit on regular expressions, so instead
  ; we'll just print out our regular expression to be used with a tool
  ; that isn't so afraid of greatness.
  ;
  ; cat /tmp/19-input | tail -n +138 | grep -E '[PASTE]' | wc -l
  (let* [(split (string-split data "\n\n"))]
    (display "^")
    (display (get-regexp-str (munge-hash (rules->hash (car split))) 0))
    (display "$")))
