#lang racket

(define sample-input
  "light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.")

(define sample-input-line
  (car (string-split sample-input "\n")))

; If I were to revisit this problem I would have built a rule struct
; and a proper parser for the input
;
; But for now we'll do a bunch of cons pairs and regex
(define (line->rules line)
  (let* [(color-match
          (regexp-match #px"(\\w+ \\w+) bags contain (.*)" line))
         (color (cadr color-match))
         (contents-raw
          (regexp-match* #px"(no other|\\d+ \\w+ \\w+) bags?"
                         (caddr color-match)))
         (contents
          (if (equal? (car contents-raw) "no other bags")
              '()
              (for/list ([entry contents-raw])
                (let [(entry-match
                       (regexp-match #px"(\\d+) (\\w+ \\w+) bags?" entry))]
                  (cons (string->number (cadr entry-match))
                        (caddr entry-match))))))]
    (list color contents)))

(define (data->rules data)
  (for/list ([line (string-split data "\n")])
    (line->rules line)))

(define (part-a data)
  (define (color-contains? color target rules)
    (let* [(candidates (cadr (assoc color rules)))
           (candidate-colors (map cdr candidates))]
      (or (member target candidate-colors)
          (for/or ([candidate candidate-colors])
            (color-contains? candidate target rules)))))

  (let [(rules (data->rules data))]
    (for/sum ([color (map car rules)])
      (if (color-contains? color "shiny gold" rules)
          1
          0))))

(define (part-b data)
  (define (total-contents color rules)
    (let [(contents (cadr (assoc color rules)))]
      (for/sum ([entry contents])
        (* (car entry)
           ; The bag itself, plus the bags inside of it
           (+ 1 (total-contents (cdr entry) rules))))))
  
  (total-contents "shiny gold" (data->rules data)))

  