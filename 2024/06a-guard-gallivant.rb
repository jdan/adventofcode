lines = $stdin.read.split "\n"

direction = :up
visited = {}

y = lines.index { |line| line.include? "^" }
x = lines[y].index "^"

while x >= 0 && y >= 0 && x < lines[0].size && y < lines.size
  visited[[x, y]] = true

  case direction
  when :up
    if lines[y-1] && lines[y-1][x] == "#"
      direction = :right
    else
      y -= 1
    end
  when :right
    if lines[y] && lines[y][x+1] == "#"
      direction = :down
    else
      x += 1
    end
  when :down
    if lines[y+1] && lines[y+1][x] == "#"
      direction = :left
    else
      y += 1
    end
  when :left
    if lines[y] && lines[y][x-1] == "#"
      direction = :up
    else
      x -= 1
    end
  end
end

puts visited.keys.size