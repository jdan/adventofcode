(ns adventofcode.2017.01-captcha
  (require [clojure.string :as str]))

(defn nth-mod
  "Performs an nth on a collection, where the index idx may wrap
   around the end of the collection."
  [coll idx]
  (nth coll (mod idx (count coll))))

(defn run-2017-01a
  [lines]
  (let [line (first lines)
        input (map #(Integer. %1)
                   (str/split line #""))]
    (reduce
     +
     (map-indexed
      (fn [idx item]
        (let [next (nth-mod input (inc idx))]
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
        (let [next (nth-mod input
                            (+ idx
                               (/ (count input) 2)))]
          (if (= item next)
            item
            0)))
      input))))
