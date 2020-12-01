# http://adventofcode.com/day/18

grid = []

ARGF.each do |line|
    grid << line.chomp.split("").map { |pixel| pixel == "#" }
end

def deep_clone(matrix)
    matrix.map(&:clone)
end

def get_live_neighbors(grid, row, col)
    neighbors = 0

    [row-1, row, row+1].each do |i|
        next if i < 0 or i >= grid.size

        [col-1, col, col+1].each do |j|
            next if j < 0 or j >= grid[i].size

            # Don't count yourself
            next if i == row and j == col

            if grid[i][j]
                neighbors += 1
            end
        end
    end

    neighbors
end

100.times do
    next_grid = deep_clone(grid)

    0.upto(grid.size - 1) do |i|
        0.upto(grid[i].size - 1) do |j|
            neighbors = get_live_neighbors(grid, i, j)

            if grid[i][j]
                # Die from overcrowding
                if neighbors < 2 or neighbors > 3
                    next_grid[i][j] = false
                end
            else
                # Exactly 3 neighbors = revive
                if neighbors == 3
                    next_grid[i][j] = true
                end
            end
        end
    end

    grid = next_grid
end

# Count the lights that are still on
puts grid.map { |row|
    row.select { |item| item }.size
}.inject(&:+)
