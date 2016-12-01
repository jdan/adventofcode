# http://adventofcode.com/day/25

match = ARGF.first.match(/row (\d+), column (\d+)/)
row = match[1].to_i
column = match[2].to_i

# Constants from the problem description
a = 20151125
mul = 252533
mod = 33554393

# Now determine, from the row and column, the index of the item under
# diagonalization
triangle_row = (column - 1) + row
n = triangle_row * (triangle_row - 1) / 2 + column

2.upto(n) do
    # Repeat the operation until we hit the index
    a = (a * mul) % mod
end

puts a
