def count_line(line)
  # count instances of XMAS AND SAMX in the line
  line.scan(/XMAS/).length + line.scan(/SAMX/).length
end

def count_horizontal(grid)
  grid
    .split("\n")
    .map { |line| count_line line }
    .inject :+
end

def count_vertical(grid)
  grid
    .split("\n")
    .map { |line| line.split "" }
    .transpose
    .map { |line| count_line line.join }
    .inject :+
end

def safe_2d_get(xss, i, j)
  if i < 0 || j < 0
    nil
  else
    xss[i] && xss[i][j]
  end
end

def count_diagonal(grid)
  lines = grid.split("\n").map { |line| line.split "" }

  total = 0
  lines.each_with_index do |line, i|
    line.each_with_index do |char, j|
      if char == "X" && safe_2d_get(lines, i+1, j+1) == "M" && safe_2d_get(lines, i+2, j+2) == "A" && safe_2d_get(lines, i+3, j+3) == "S"
        total += 1
      end

      if char == "S" && safe_2d_get(lines, i+1, j+1) == "A" && safe_2d_get(lines, i+2, j+2) == "M" && safe_2d_get(lines, i+3, j+3) == "X"
        total += 1
      end

      if char == "X" && safe_2d_get(lines, i+1, j-1) == "M" && safe_2d_get(lines, i+2, j-2) == "A" && safe_2d_get(lines, i+3, j-3) == "S"
        total += 1
      end

      if char == "S" && safe_2d_get(lines, i+1, j-1) == "A" && safe_2d_get(lines, i+2, j-2) == "M" && safe_2d_get(lines, i+3, j-3) == "X"
        total += 1
      end
    end
  end
  total
end

grid = $stdin.read
puts count_horizontal(grid) + count_vertical(grid) + count_diagonal(grid)