# http://adventofcode.com/day/3

presents = Hash.new(0)

santa_position = [0, 0]
robo_position = [0, 0]

presents["0,0"] += 1

gets.chomp.split("").each_with_index do |direction, i|
    if i.even?
        position = santa_position
    else
        position = robo_position
    end

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
