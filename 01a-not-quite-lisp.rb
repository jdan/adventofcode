# http://adventofcode.com/day/1

parens = gets.chomp
floor = 0

parens.each_char do |char|
    if char == "("
        floor += 1
    elsif char == ")"
        floor -= 1
    end
end

puts floor
