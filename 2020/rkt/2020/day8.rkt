#lang racket

(define (data->instrs data)
  (for/list ([line (string-split data "\n")])
    (let [(match (regexp-match #px"(\\w+) ((\\+|-)\\d+)" line))]
      (cons (string->symbol (cadr match))
            (string->number (caddr match))))))

(define (exec instrs)
  (define (inner instrs pc acc visited)
    (cond [(set-member? visited pc)
           (list 'loop acc)]
          [(>= pc (length instrs))
           (list 'halt acc)]
          [else 
           (let [(instr (list-ref instrs pc))]
             (cond [(eq? 'nop (car instr))
                    (inner instrs
                           (+ pc 1)
                           acc
                           (set-add visited pc))]
                   [(eq? 'acc (car instr))
                    (inner instrs
                           (+ pc 1)
                           (+ acc (cdr instr))
                           (set-add visited pc))]
                   [(eq? 'jmp (car instr))
                    (inner instrs
                           (+ pc (cdr instr))
                           acc
                           (set-add visited pc))]
                   [else (error "unknown instruction" instr)]))]))

  (inner instrs 0 0 (set)))

(define (part-a data)
  (cadr (exec (data->instrs data))))

(define (part-b data)
  (define (flip-instr instr)
    (cond [(eq? 'nop (car instr))
           (cons 'jmp (cdr instr))]
          [(eq? 'jmp (car instr))
           (cons 'nop (cdr instr))]
          [else instr]))

  (define (possible-instr-changes instrs)
    (remove-duplicates
     (for/list ([i (in-range (length instrs))])
       (list-update instrs i flip-instr))))
  
  (let [(input-instrs (data->instrs data))]
    (for/first ([instrs (possible-instr-changes input-instrs)]
                #:when (eq? 'halt (car (exec instrs))))
      (cadr (exec instrs)))))
