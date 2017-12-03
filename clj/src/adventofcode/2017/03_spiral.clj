(ns adventofcode.2017.03-spiral)

(defn biggest-odd-sqrt
  "Finds the largest odd number whose square is less than n."
  [n]
  (let [sqrt-candidate (int (Math/sqrt n))]
    (if (odd? sqrt-candidate)
      sqrt-candidate
      (dec sqrt-candidate))))

(defn distance
  "Finds the taxicab distance from (x, y) to the origin"
  [x y]
  (+ (Math/abs x) (Math/abs y)))

(defn run-2017-03a
  [lines]
  (let [input (Integer. (first lines))
        start (biggest-odd-sqrt input)
        x (quot start 2)
        y (* -1 x)

        length (inc start)
        ; Corner values
        bottom-right (* start start)
        top-right (+ bottom-right length)
        top-left (+ top-right length)
        bottom-left (+ top-left length)
        next-bottom-right (+ bottom-left length)]
    (cond
      (= bottom-right input) (distance x y)
      ; Right side
      (<= input top-right)
      (distance (inc x)
                (+ y (- input bottom-right 1)))

      ; Top side
      (<= input top-left)
      (distance (- x (- input top-right 1))
                (+ y (- length 1)))

      ; Left side
      (<= input bottom-left)
      (distance (- x length)
                (+ y (- bottom-left input)))

      ; Bottom side
      :else
      (distance (- (inc x) (- next-bottom-right input))
                (dec y)))))
