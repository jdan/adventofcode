# frozen_string_literal: true

module Solution
  def self.part_a(input)
    grid = Grid.new(input)
    count = 0

    grid.each_cell do |x, y|
      next if grid.get_cell(x, y) != '@'

      neighbors = grid.neighbors(x, y)
      rolls = neighbors.count { |cell| cell == '@' }
      count += 1 if rolls < 4
    end

    count
  end

  def self.part_b(input)
    grid = Grid.new(input)
    total_removals = 0

    loop do
      removal_queue = []

      grid.each_cell do |x, y|
        next if grid.get_cell(x, y) != '@'

        neighbors = grid.neighbors(x, y)
        rolls = neighbors.count { |cell| cell == '@' }
        if rolls < 4
          total_removals += 1
          removal_queue << [x, y]
        end
      end

      break if removal_queue.empty?

      removal_queue.each do |pair|
        grid.set_cell(pair[0], pair[1], '.')
      end
    end

    total_removals
  end
end

class Grid
  def initialize(input)
    @grid = input.lines.map { |line| line.chomp.split('') }
  end

  def to_s
    @grid.map { |row| row.join }.join("\n")
  end

  def each_cell
    0.upto(@grid.size - 1) do |row|
      0.upto(@grid[row].size - 1) do |col|
        yield row, col
      end
    end
  end

  def get_cell(x, y)
    return nil if y < 0 || y >= @grid.size

    row = @grid[y]

    return nil if x < 0 || x >= row.size

    row[x]
  end

  def set_cell(x, y, new_value)
    return nil if get_cell(x, y).nil?

    @grid[y][x] = new_value
  end

  def neighbors(x, y)
    [-1, 0, 1].product([-1, 0, 1]).select do |pair|
      !(pair[0] == 0 and pair[1] == 0)
    end.map { |pair| get_cell(x + pair[0], y + pair[1]) }
  end
end

puts Solution.part_b $stdin.read
