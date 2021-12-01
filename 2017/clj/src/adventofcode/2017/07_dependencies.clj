(ns adventofcode.2017.07-dependencies
  (require [clojure.string :as str]
           [clojure.set :as set]))

(defn parse-node
  [node]
  (let [[_ name weight] (re-matches #"(\w+)\s\((\d+)\)" node)]
    {:name name
     :weight (Integer. weight)
     :holds []}))

(defn parse-dependencies
  [dependencies]
  (str/split dependencies #", "))

(defn parse-line
  [line]
  (if (str/includes? line "->")
    (let [[raw-node raw-dependencies] (str/split line #" -> ")
          node (parse-node raw-node)
          dependencies (parse-dependencies raw-dependencies)]
      (assoc node :holds dependencies))
    (parse-node line)))

(defn part-a
  [lines]
  (let [data (map parse-line lines)
        all-names (set (map :name data))
        all-held (set (flatten (map :holds data)))]
    (first (vec
            ; Find a node that isn't held
            (set/difference all-names all-held)))))
