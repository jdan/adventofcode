#lang racket

(define (data->ls data)
  (for/list ([line (string-split data)])
    (cons (string-ref line 0)
          (string->number (substring line 1)))))

(define (change-pos state f)
  (cons (f (car state))
        (cdr state)))

(define (angle->dir angle)
  (let [(theta (modulo angle 360))]
    (cond [(= theta 0) #\E]
          [(= theta 90) #\N]
          [(= theta 180) #\W]
          [(= theta 270) #\S]
          [else (error "Unknown theta --" theta)])))

(define (part-a data)
  ; Sooo many cars and cdrs... state should really be a struct
  ; with getters and setters
  (define (move instr state)
    (cond [(eq? #\N (car instr))
           (change-pos state
                       (λ (xy)
                         (cons (car xy)
                               (+ (cdr xy) (cdr instr)))))]
          [(eq? #\S (car instr))
           (change-pos state
                       (λ (xy)
                         (cons (car xy)
                               (- (cdr xy) (cdr instr)))))]
          [(eq? #\E (car instr))
           (change-pos state
                       (λ (xy)
                         (cons (+ (car xy) (cdr instr))
                               (cdr xy))))]
          [(eq? #\W (car instr))
           (change-pos state
                       (λ (xy)
                         (cons (- (car xy) (cdr instr))
                               (cdr xy))))]
          [(eq? #\F (car instr))
           ; Convert F to a direction move
           (move (cons (angle->dir (cdr state)) (cdr instr)) state)]
          [(eq? #\L (car instr))
           (cons (car state)
                 (+ (cdr state) (cdr instr)))]
          [(eq? #\R (car instr))
           (cons (car state)
                 (- (cdr state) (cdr instr)))]
          [else (error "Unknown instr --" instr)]))
  
  (let* [(instrs (data->ls data))
         (init-state (cons (cons 0 0) 0))
         (end-state (foldl move init-state instrs))]
    (+ (abs (caar end-state)) (abs (cdar end-state)))))

(define (part-b data)
  (define (move instr state)
    (cond [(eq? #\N (car instr))
           (change-pos state
                       (λ (xy)
                         (cons (car xy)
                               (+ (cdr xy) (cdr instr)))))]
          [(eq? #\S (car instr))
           (change-pos state
                       (λ (xy)
                         (cons (car xy)
                               (- (cdr xy) (cdr instr)))))]
          [(eq? #\E (car instr))
           (change-pos state
                       (λ (xy)
                         (cons (+ (car xy) (cdr instr))
                               (cdr xy))))]
          [(eq? #\W (car instr))
           (change-pos state
                       (λ (xy)
                         (cons (- (car xy) (cdr instr))
                               (cdr xy))))]
          [(eq? #\F (car instr))
           (cons (car state)
                 (cons (+ (cadr state)
                          (* (cdr instr) (caar state)))
                       (+ (cddr state)
                          (* (cdr instr) (cdar state)))))]
          [(eq? #\L (car instr))
           (let ([x (caar state)]
                 [y (cdar state)])
             (cond [(= 90 (cdr instr))
                    (cons (cons (- y) x) (cdr state))]
                   [(= 180 (cdr instr))
                    (cons (cons (- x) (- y)) (cdr state))]
                   [(= 270 (cdr instr))
                    (cons (cons y (- x)) (cdr state))]))]
          [(eq? #\R (car instr))
           (move (cons #\L (- 360 (cdr instr))) state)]
          [else (error "Unknown instr --" instr)]))

  (let* [(instrs (data->ls data))
         (init-state (cons (cons 10 1) (cons 0 0)))
         (end-state (foldl move init-state instrs))]
    (+ (abs (cadr end-state)) (abs (cddr end-state)))))