(ns adventofcode.core-test
  (:require [clojure.test :refer :all]
            [adventofcode.core :refer :all]))

(deftest a-test
  (testing "invalid runner id"
    (is (= "error: invalid runner id = inv_id" (run "inv_id" []))))

  (testing "2017 day 1A tests"
    (is (= 3 (run "2017.01a" ["1122"])))
    (is (= 4 (run "2017.01a" ["1111"])))
    (is (= 0 (run "2017.01a" ["1234"])))
    (is (= 9 (run "2017.01a" ["91212129"]))))

  (testing "2017 day 1B tests"
    (is (= 6 (run "2017.01b" ["1212"])))
    (is (= 0 (run "2017.01b" ["1221"])))
    (is (= 4 (run "2017.01b" ["123425"])))
    (is (= 12 (run "2017.01b" ["123123"])))
    (is (= 4 (run "2017.01b" ["12131415"]))))

  (testing "2017 day 3A tests"
    (is (= 1 (run "2017.03a" ["4"])))
    (is (= 2 (run "2017.03a" ["5"])))
    (is (= 3 (run "2017.03a" ["12"])))
    (is (= 2 (run "2017.03a" ["15"])))
    (is (= 2 (run "2017.03a" ["23"])))
    (is (= 31 (run "2017.03a" ["1024"]))))

  (testing "2017 day 3B tests"
    (is (= 4 (run "2017.03b" ["3"])))
    (is (= 10 (run "2017.03b" ["8"])))
    (is (= 23 (run "2017.03b" ["20"])))
    (is (= 747 (run "2017.03b" ["700"]))))

  (testing "2017 day 4A tests"
    (is (= 1 (run "2017.04a" ["aa bb cc dd ee"])))
    (is (= 0 (run "2017.04a" ["aa bb cc dd aa"])))
    (is (= 1 (run "2017.04a" ["aa bb cc dd ee aaa"])))
    (is (= 2 (run "2017.04a" ["aa bb cc dd ee"
                              "aa bb cc dd aa"
                              "aa bb cc dd ee aaa"]))))

  (testing "2017 day 4B tests"
    (is (= 1 (run "2017.04b" ["abcde fghij"])))
    (is (= 0 (run "2017.04b" ["abcde xyz ecdab"])))
    (is (= 1 (run "2017.04b" ["a ab abc abd abf abj"])))
    (is (= 1 (run "2017.04b" ["iiii oiii ooii oooi oooo"])))
    (is (= 0 (run "2017.04b" ["oiii ioii iioi iiio"])))
    (is (= 3 (run "2017.04b" ["abcde fghij"
                              "abcde xyz ecdab"
                              "a ab abc abd abf abj"
                              "iiii oiii ooii oooi oooo"
                              "oiii ioii iioi iiio"]))))

  (testing "2017 day 5A tests"
    (is (= 5 (run "2017.05a" ["0" "3" "0" "1" "-3"]))))

  (testing "2017 day 5B tests"
    (is (= 10 (run "2017.05b" ["0" "3" "0" "1" "-3"]))))

  (testing "2017 day 6A tests"
    (is (= 5 (run "2017.06a" ["0 2 7 0"]))))

  (testing "2017 day 6B tests"
    (is (= 4 (run "2017.06b" ["0 2 7 0"]))))

  (testing "2017 day 7A tests"
    (is (= "tknk"
      (run "2017.07a"
        ["pbga (66)"
        "xhth (57)"
        "ebii (61)"
        "havc (66)"
        "ktlj (57)"
        "fwft (72) -> ktlj, cntj, xhth"
        "qoyq (66)"
        "padx (45) -> pbga, havc, qoyq"
        "tknk (41) -> ugml, padx, fwft"
        "jptl (61)"
        "ugml (68) -> gyxo, ebii, jptl"
        "gyxo (61)"
        "cntj (57)"])))))
