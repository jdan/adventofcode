def print_grid(grid, visited)
  grid.each_with_index do |row, y|
    row.split("").each_with_index do |cell, x|
      if visited[[x,y]]
        print "X"
      else
        print cell
      end
    end
    puts
  end
end

def loops?(lines)
  direction = :up
  visited = {}

  y = lines.index { |line| line.include? "^" }
  x = lines[y].index "^"

  while x >= 0 && y >= 0 && x < lines[0].size && y < lines.size
    # add direction to the set of visited[[x,y]]
    visited[[x,y]] ||= {}

    if visited[[x,y]][direction]
      # we're in a loop!
      # puts "LOOP"
      # print_grid(lines, visited)
      # puts
      return true
    end

    visited[[x,y]][direction] = true

    case direction
    when :up
      # don't go negative, as in ruby arr[-1] is the last item
      # but our grid is not on a torus
      if y-1 >= 0 && lines[y-1] && lines[y-1][x] == "#"
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
      if x-1 >= 0 && lines[y] && lines[y][x-1] == "#"
        direction = :up
      else
        x -= 1
      end
    end
  end

  # no loop, the guard escapes
  # puts "ESCAPED"
  # print_grid(lines, visited)
  # puts
  false
end

GRID1 = <<GRID
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
GRID

GRID2 = <<GRID
....#.....
.........#
..........
..#.......
.......#..
..........
.#.#^.....
........#.
#.........
......#...
GRID

GRID3 = <<GRID
..#.
....
.#^.
..#.
GRID

# inline unit test if the user passes in -t
if ARGV[0] == "-t"
  p loops?(GRID1.split("\n")) == false
  p loops?(GRID2.split("\n")) == true
else 
  lines = $stdin.read.split("\n")
  valid_obstructions = 0

  0.upto(lines.size - 1) do |y|
    p y.to_f / lines.size
    0.upto(lines[y].size - 1) do |x|
      next if lines[y][x] == "^"
      # TODO: optimization
      # only place obstacles along the path the guard
      # takes to escape
      next if lines[y][x] == "#"

      # deep copy lines
      lines_copy = lines.map(&:dup)
      lines_copy[y][x] = "#"
      if loops?(lines_copy)
        puts "(#{y},#{x})"
        valid_obstructions += 1
      end
    end
  end

  p valid_obstructions
end