(ns adventofcode.2017.01-captcha
  (require [clojure.string :as str]))

(defn nth-mod
  "Performs an nth on a collection, where the index idx may wrap
   around the end of the collection."
  [coll idx]
  (nth coll (mod idx (count coll))))

(defn sum-matches
  "Shared code for parts A and B, in which we sum up matching values
   in a row based on a `get-next-item` function which computes the
   next item in a list based on the current index."
  [get-next-item]
  (fn [lines]
    (let [line (first lines)
          input (map #(Integer. %1)
                     (str/split line #""))]
      (reduce
       +
       (map-indexed
        (fn [idx item]
          (if (= item (get-next-item input idx))
            item
            0))
        input)))))

(def part-a
  (sum-matches
   (fn [input idx] (nth-mod input (inc idx)))))

(def part-b
  (sum-matches
   (fn [input idx]
     (nth-mod input
              (+ (/ (count input) 2)
                 idx)))))
