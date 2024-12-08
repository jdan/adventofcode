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
      dx = (pos1[0] - pos2[0]).abs
      dy = (pos1[1] - pos2[1]).abs

      thru_pos1 = [
        pos1[0] < pos2[0] ? pos1[0] - dx : pos1[0] + dx,
        pos1[1] < pos2[1] ? pos1[1] - dy : pos1[1] + dy,
      ]
      # if thru_pos1 is within the bounds of the
      # map, add it as a unique antinode
      if thru_pos1[0] >= 0 && thru_pos1[0] < map_width &&
          thru_pos1[1] >= 0 && thru_pos1[1] < map_height
        unique_antinodes[thru_pos1] = true
      end

      thru_pos2 = [
        pos1[0] < pos2[0] ? pos2[0] + dx : pos2[0] - dx,
        pos1[1] < pos2[1] ? pos2[1] + dy : pos2[1] - dy,
      ]
      # if thru_pos2 is within the bounds of the
      # map, add it as a unique antinode
      if thru_pos2[0] >= 0 && thru_pos2[0] < map_width &&
          thru_pos2[1] >= 0 && thru_pos2[1] < map_height
        unique_antinodes[thru_pos2] = true
      end
    end
  end

  unique_antinodes.size
end

p unique_antinodes($stdin.read.split("\n"))
