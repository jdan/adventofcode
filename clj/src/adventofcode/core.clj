(ns adventofcode.core
  (:require
   [adventofcode.2017.01-captcha
    :refer [part-a part-b]
    :rename {part-a run-2017-01a part-b run-2017-01b}]
   [adventofcode.2017.03-spiral
    :refer [part-a part-b]
    :rename {part-a run-2017-03a part-b run-2017-03b}]
   [adventofcode.2017.04-passphrase
    :refer [part-a part-b]
    :rename {part-a run-2017-04a
             part-b run-2017-04b}]
   [adventofcode.2017.05-jumps
    :refer [part-a part-b]
    :rename {part-a run-2017-05a
    part-b run-2017-05b}]))

(def runners
  {"2017.01a" run-2017-01a
   "2017.01b" run-2017-01b
   "2017.03a" run-2017-03a
   "2017.03b" run-2017-03b
   "2017.04a" run-2017-04a
   "2017.04b" run-2017-04b
   "2017.05a" run-2017-05a
   "2017.05b" run-2017-05b})

(defn run [id input]
  (let [runner (runners id)]
    (if (nil? runner)
      (str "error: invalid runner id = " id)
      (runner input))))

(defn -main
  [id]
  (let [stdin (line-seq (java.io.BufferedReader. *in*))]
    (println (run id stdin))))
