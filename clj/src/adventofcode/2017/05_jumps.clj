(ns adventofcode.2017.05-jumps)

(defn part-a
  [lines]
  (loop [jumps (vec (map #(Integer. %1) lines))
         pos 0
         steps 0]
    (if (or (>= pos (count jumps))
            (< pos 0))
      steps
      (recur
       ; Increment jumps[pos]
       (assoc jumps pos (inc (get jumps pos)))
       (+ pos (get jumps pos))
       (inc steps)))))

(defn part-b
  [lines]
  (loop [jumps (vec (map #(Integer. %1) lines))
         pos 0
         steps 0]
    (if (or (>= pos (count jumps))
      (< pos 0))
      steps
      (recur
       ; Modify jumps[pos]
       (assoc jumps pos
              (if (>= (get jumps pos) 3)
                (dec (get jumps pos))
                (inc (get jumps pos))))
       (+ pos (get jumps pos))
       (inc steps)))))

