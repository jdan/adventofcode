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
    (is (= 747 (run "2017.03b" ["700"])))))
