(ns adventofcode.2017.03-spiral)

(defn next-pos
  "Gets the next pos"
  [pos dir]
  (let [[x y] pos]
    (cond
      (= dir :up) [x (inc y)]
      (= dir :left) [(dec x) y]
      (= dir :down) [x (dec y)]
      (= dir :right) [(inc x) y])))

(defn next-dir
  "Gets the next-direction"
  [dir left-before-turn]
  (if (= left-before-turn 0)
    ({:up :left
      :left :down
      :down :right
      :right :up} dir)
    dir))

(defn next-travel-length
  "Gets the next travel length"
  [direction left-before-turn travel-length]
  (if (> left-before-turn 0)
    travel-length
    (if (or (= :left direction)
            (= :right direction))
      (inc travel-length)
      travel-length)))

(defn next-left-before-turn
  "Gets the next left-before-turn"
  [direction left-before-turn travel-length]
  (if (> left-before-turn 0)
    (dec left-before-turn)
    (next-travel-length direction left-before-turn travel-length)))

(defn run-spiral
  "Runs a spiral"
  [args]
  (let [{:keys [board pos last-value direction
                travel-length left-before-turn
                get-square-value is-done]} args
        new-value (get-square-value last-value board pos)
        new-board (assoc board pos new-value)
        new-dir (next-dir direction left-before-turn)
        new-pos (next-pos pos new-dir)
        new-travel-length (next-travel-length
                           new-dir left-before-turn travel-length)
        new-left-before-turn (next-left-before-turn
                              new-dir left-before-turn travel-length)]
    (if (is-done new-value)
      [new-value board pos]
      (recur
       {:board new-board
        :pos new-pos
        :last-value new-value
        :direction new-dir
        :travel-length new-travel-length
        :left-before-turn new-left-before-turn
        :get-square-value get-square-value
        :is-done is-done}))))

(defn distance
  "Computes taxicab distance"
  [x y]
  (+ (Math/abs x) (Math/abs y)))

(defn run-2017-03a
  [lines]
  (let
   [input (Integer. (first lines))
    [_ _ [x y]]
    (run-spiral
     {:board {[0 0] 1}
      :pos [1 0]
      :last-value 1
      :direction :right
      :travel-length 0
      :left-before-turn 0
      :get-square-value (fn [last-value _ _] (inc last-value))
      :is-done #(= input %1)})]
    (distance x y)))
