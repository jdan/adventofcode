(ns adventofcode.core
  (require [adventofcode.2017.01-captcha :refer :all]
           [adventofcode.2017.03-spiral :refer :all]))

(def runners
  {"2017.01a" run-2017-01a
   "2017.01b" run-2017-01b
   "2017.03a" run-2017-03a})

(defn run [id input]
  (let [runner (runners id)]
    (if (nil? runner)
      (str "error: invalid runner id = " id)
      (runner input))))

(defn -main
  [id]
  (let [stdin (line-seq (java.io.BufferedReader. *in*))]
    (println (run id stdin))))
