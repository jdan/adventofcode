BEGIN {  total = 0 }

/A X/ { total += 1 + 3 }
/A Y/ { total += 2 + 6 }
/A Z/ { total += 3 }
/B X/ { total += 1 }
/B Y/ { total += 2 + 3 }
/B Z/ { total += 3 + 6 }
/C X/ { total += 1 + 6 }
/C Y/ { total += 2 }
/C Z/ { total += 3 + 3 }

END { print total }
