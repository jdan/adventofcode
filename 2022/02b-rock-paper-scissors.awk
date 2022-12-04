BEGIN {  total = 0 }

/A X/ { total += 3 + 0 }
/A Y/ { total += 1 + 3 }
/A Z/ { total += 2 + 6 }
/B X/ { total += 1 + 0 }
/B Y/ { total += 2 + 3 }
/B Z/ { total += 3 + 6 }
/C X/ { total += 2 + 0 }
/C Y/ { total += 3 + 3 }
/C Z/ { total += 1 + 6 }

END { print total }
