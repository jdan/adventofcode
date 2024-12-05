total = 0
lines = $stdin.readlines

0.upto(lines.length - 3) do |i|
  0.upto(lines[i].length - 3) do |j|
    if lines[i][j..j+2].match /M.S/ and lines[i+1][j..j+2].match /.A./ and lines[i+2][j..j+2].match /M.S/
      total += 1
    end

    if lines[i][j..j+2].match /M.M/ and lines[i+1][j..j+2].match /.A./ and lines[i+2][j..j+2].match /S.S/
      total += 1
    end

    if lines[i][j..j+2].match /S.S/ and lines[i+1][j..j+2].match /.A./ and lines[i+2][j..j+2].match /M.M/
      total += 1
    end

    if lines[i][j..j+2].match /S.M/ and lines[i+1][j..j+2].match /.A./ and lines[i+2][j..j+2].match /S.M/
      total += 1
    end
  end
end

puts total
