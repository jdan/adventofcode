(ns adventofcode.2017.01-captcha
  (require [clojure.string :as str]))

(defn run-2017-01a
  [lines]
  (let [line (first lines)
        input (map #(Integer. %1)
                   (str/split line #""))]
    (reduce
     +
     (map-indexed
      (fn [idx item]
        (let [next (nth input
                        (mod (inc idx) (count input)))]
          (if (= item next)
            item
            0)))
      input))))

(defn run-2017-01b
  [lines]
  (let [line (first lines)
        input (map #(Integer. %1)
                   (str/split line #""))]
    (reduce
     +
     (map-indexed
      (fn [idx item]
        (let [next (nth input
                        (mod (+ idx (/ (count input) 2)) (count input)))]
          (if (= item next)
            item
            0)))
      input))))
