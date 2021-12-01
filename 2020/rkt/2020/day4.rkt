#lang racket

(define (all? pred ls)
  (if (empty? ls)
      #t
      (and (pred (car ls))
           (all? pred (cdr ls)))))

(define (part-a input)
  (length
   (filter
    (λ (entry)
      (all? (λ (required-key)
              (string-contains? entry required-key))
            '("byr:" "iyr:" "eyr:" "hgt:" "hcl:" "ecl:" "pid:")))
    (string-split input "\n\n"))))

(define part-b/rules
  (list (cons #px"byr:(\\d{4})\\b"
              (λ (match)
                (let [(d (string->number (car match)))]
                  (and (>= d 1920) (<= d 2002)))))

        (cons #px"iyr:(\\d{4})\\b"
              (λ (match)
                (let [(d (string->number (car match)))]
                  (and (>= d 2010) (<= d 2020)))))

        (cons #px"eyr:(\\d{4})\\b"
              (λ (match)
                (let [(d (string->number (car match)))]
                  (and (>= d 2020) (<= d 2030)))))

        (cons #px"hgt:(\\d+)(cm|in)\\b"
              (λ (match)
                (let [(amt (string->number (car match)))
                      (cm? (equal? "cm" (cadr match)))]
                  (if cm?
                      (and (>= amt 150) (<= amt 193))
                      (and (>= amt 59) (<= amt 76))))))

        (cons #px"hcl:#[0-9a-f]{6}\\b" (λ (_) #t))
        (cons #px"ecl:(amb|blu|brn|gry|grn|hzl|oth)\\b" (λ (_) #t))
        (cons #px"pid:\\d{9}\\b" (λ (_) #t))))

(define (part-b input)
  (length
   (filter
    (λ (entry)
      (all? (λ (rule)
              (let* [(re (car rule))
                     (pred (cdr rule))
                     (match (regexp-match re entry))]
                (and match
                     (pred (cdr match)))))
            part-b/rules))
    (string-split input "\n\n"))))