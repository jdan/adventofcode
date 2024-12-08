TEST_MAP = <<MAP
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
MAP

def within_bounds?(map, x, y)
  map_height = map.size
  map_width = map[0].size
  x >= 0 && x < map_width && y >= 0 && y < map_height
end

def unique_antinodes(map)
  map_height = map.size
  map_width = map[0].size

  # Store all the node positions
  pos_by_node = {}
  0.upto(map_height - 1) do |y|
    0.upto(map_width - 1) do |x|
      # single digit, lowercase letter, uppercase letter
      if map[y][x] =~ /[0-9a-zA-Z]/
        # add to the list
        pos_by_node[map[y][x]] ||= []
        pos_by_node[map[y][x]] << [x, y]
      end
    end
  end

  # Now count the antinodes
  unique_antinodes = {}

  # for each node type
  pos_by_node.map do |node, positions|
    # for each pair of positions
    positions.combination(2).map do |pos1, pos2|
      # Remove the abs, as we want dx and dy to have different signs
      dx = pos1[0] - pos2[0]
      dy = pos1[1] - pos2[1]

      # count "forwards"
      mul = 0
      while true
        pos = [pos1[0] + dx * mul, pos1[1] + dy * mul]
        break unless within_bounds?(map, pos[0], pos[1])
        unique_antinodes[pos] = true
        mul += 1
      end

      # count "backwards"
      mul = -1
      while true
        pos = [pos1[0] + dx * mul, pos1[1] + dy * mul]
        break unless within_bounds?(map, pos[0], pos[1])
        unique_antinodes[pos] = true
        mul -= 1
      end
    end
  end

  # draw the antinodes on a grid
  map.each_with_index do |row, y|
    row.each_char.with_index do |cell, x|
      if unique_antinodes[[x, y]]
        print '#'
      else
        print cell
      end
    end
    puts
  end

  unique_antinodes.size
end

p unique_antinodes($stdin.read.split("\n"))
