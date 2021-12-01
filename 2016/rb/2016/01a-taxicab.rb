# http://adventofcode.com/2016/day/1

x, y = 0, 0
heading = :up

heading_delta = {
    up: { L: :left, R: :right },
    right: { L: :up, R: :down },
    down: { L: :right, R: :left },
    left: { L: :down, R: :up },
}

def make_move(x, y, heading, dist)
    case heading
    when :up
        y += dist
    when :down
        y -= dist
    when :right
        x += dist
    when :left
        x -= dist
    end

    return [x, y]
end

gets.chomp.split(", ").each do |direction|
    turn = direction[0].to_sym
    distance = direction[1..-1].to_i

    heading = heading_delta[heading][turn]
    x, y = make_move(x, y, heading, distance)
end

puts x.abs + y.abs
