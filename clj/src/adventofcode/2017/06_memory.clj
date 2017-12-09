(ns adventofcode.2017.06-memory
  (require [clojure.string :as str]))

(defn inc-at
  "Increments a vector v at index idx"
  [v idx]
  (assoc v idx (inc (get v idx))))

(defn dec-at
  "Decrements a vector v at index idx"
  [v idx]
  (assoc v idx (dec (get v idx))))

(defn redistribute
  [banks]
  (let [max-amt (apply max banks)
        max-idx (.indexOf banks max-amt)]
    (loop [banks banks
           shift 1
           amt-to-redistribute max-amt]
      (if (zero? amt-to-redistribute)
        banks
        (let [idx (mod (+ max-idx shift) (count banks))]
          (recur
           (inc-at
            (dec-at banks max-idx)
            idx)
           (inc shift)
           (dec amt-to-redistribute)))))))

(defn part-a
  [lines]
  (let [line (first lines)]
    (loop [banks (vec (map #(Integer. %1) (str/split line #"\s+")))
           seen #{}
           count 0]
      (if (contains? seen banks)
        count
        (let [new-banks (redistribute banks)]
          (recur
           new-banks
           (conj seen banks)
           (inc count)))))))

(defn part-b
  [lines]
  (let [line (first lines)]
    (loop [banks (vec (map #(Integer. %1) (str/split line #"\s+")))
           seen {}
           count 0]
      (if (contains? (set (keys seen)) banks)
        (- count (seen banks))
        (let [new-banks (redistribute banks)]
          (recur
           new-banks
           (conj seen {banks count})
           (inc count)))))))
