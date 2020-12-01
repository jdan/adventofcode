# http://adventofcode.com/day/12

total = 0

ARGF.each do |line|
    total += line.scan(/-?\d+/).map(&:to_i).reduce(&:+)
end

puts total
