{
  l = length($0)
  a = substr($0, 0, l/2)
  b = substr($0, l/2+1)

  # find the character that appears in both a and b
  for (i = 1; i <= length(a); i++) {
    c = substr(a, i, 1)
    if (index(b, c) > 0) {
      # encode c as a number from to 1-52
      if (c >= "a" && c <= "z") {
        c = index("abcdefghijklmnopqrstuvwxyz", c)
      } else {
        c = 26 + index("ABCDEFGHIJKLMNOPQRSTUVWXYZ", c)
      }
      total += c
      break
    }
  }
}

END { print total }
