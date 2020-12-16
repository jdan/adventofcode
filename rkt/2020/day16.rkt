#lang racket

(define (caddddr ls) (car (cddddr ls)))

(define (line->pred line)
  (let [(match (regexp-match #px"\\w+: (\\d+)-(\\d+) or (\\d+)-(\\d+)" line))]
    (λ (n)
      (or (and (>= n (string->number (cadr match)))
               (<= n (string->number (caddr match))))
          (and (>= n (string->number (cadddr match)))
               (<= n (string->number (caddddr match))))))))

(define (data->sections data)
  (let* [(sections (string-split data "\n\n"))
         (rules (for/vector ([line (string-split (car sections) "\n")])
                  (line->pred line)))
         (your-ticket
          (for/list ([item (string-split
                            (cadr (string-split (cadr sections) "\n"))
                            ",")])
            (string->number item)))
         (nearby-tickets
          (for/list ([line (cdr (string-split (caddr sections) "\n"))])
            (map string->number (string-split line ","))))]
    (values rules your-ticket nearby-tickets)))

(define (part-a data)
  (let-values ([(rules your-ticket nearby-tickets) (data->sections data)])
    (for/sum ([n (flatten nearby-tickets)])
      (if (for/or ([rule rules]) (rule n))
          0
          n))))

; '((1) (0 1) (0 1 2)) => '((1) (0) (2))
(define (disambiguate ls)
  (define (all-unique? ls)
    (for/and ([entry ls])
      (null? (cdr entry))))
  
  (define (inner ls seen)
    (if (all-unique? ls)
        ls
        (let [(next-unique
               (for/first ([entry ls]
                           #:when (and (null? (cdr entry))
                                       (not (set-member? seen (car entry)))))
                 (car entry)))]
          (inner (for/list ([entry ls])
                   (if (null? (cdr entry))
                       entry
                       (remove next-unique entry)))
                 (set-add seen next-unique)))))

  (inner ls (set)))

(define (part-b data)
  (define (valid? ticket rules)
    (for/and ([value ticket])
      (for/or ([rule rules]) (rule value))))

  (define (valid-positions rules your-ticket nearby-tickets)
    (for/fold
     ([viable-rules (for/list ([i (in-range (length your-ticket))])
                      (for/list ([pos (in-range (vector-length rules))]) pos))])
     ([ticket nearby-tickets]
      #:when (valid? ticket rules))
      (for/list ([viable-rule viable-rules]
                 [value ticket])
        (for/list ([pos viable-rule]
                   #:when ((vector-ref rules pos) value))
          pos))))
  
  (let-values ([(rules your-ticket nearby-tickets) (data->sections data)])
    (for/product ([ticket-value your-ticket]
                  [column 
                   (disambiguate
                    (valid-positions rules your-ticket nearby-tickets))]
                  ; Multiply the first 6 columns (which begin with departure)
                  #:when (< (car column) 6))
      ticket-value)))