# http://adventofcode.com/day/3

presents = Hash.new(0)
position = [0, 0]

presents[position.join(",")] += 1

gets.chomp.each_char do |direction|
    case direction
    when ">"
        position[0] += 1
    when "<"
        position[0] -= 1
    when "^"
        position[1] -= 1
    when "v"
        position[1] += 1
    end

    presents[position.join(",")] += 1
end

puts presents.length
