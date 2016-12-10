# http://adventofcode.com/2016/day/3

possible = 0

ARGF.each do |line|
    sides = line.scan(/\d+/).map(&:to_i)
    if (sides[0] + sides[1] > sides[2]) && (sides[1] + sides[2] > sides[0]) && (sides[2] + sides[0] > sides[1])
        possible += 1
    end
end

puts possible