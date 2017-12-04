(ns adventofcode.2017.04-passphrase
  (require [clojure.string :as str]))

(defn part-a
  [lines]
  (let [valid-passphrase?
        (fn [line]
          (apply distinct? (str/split line #" ")))]
    (count (filter valid-passphrase? lines))))

(defn part-b
  [lines]
  (let [valid-passphrase?
        (fn [line]
          (apply distinct?
                 (map sort (str/split line #" "))))]
    (count (filter valid-passphrase? lines))))
