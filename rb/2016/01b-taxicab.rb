# http://adventofcode.com/2016/day/1

x, y = 0, 0
heading = :up

# Transition a heading and direction to a new heading
heading_delta = {
    up: { L: :left, R: :right },
    right: { L: :up, R: :down },
    down: { L: :right, R: :left },
    left: { L: :down, R: :up },
}

visited_coords = {}

gets.chomp.split(", ").each do |direction|
    turn = direction[0].to_sym
    distance = direction[1..-1].to_i

    # Check if we've visited (x, y) before and, if not, add it to our hash
    # of visited coordinates
    check = ->(x, y) {
        key = "#{x}-#{y}"
        if visited_coords.has_key? key
            puts x.abs + y.abs
            exit
        else
            visited_coords[key] = true
        end
    }

    heading = heading_delta[heading][turn]

    case heading
    when :up
        (y+1..y+distance).each { |ny| check.(x, ny) }
        y += distance
    when :down
        (y-distance...y).each { |ny| check.(x, ny) }
        y -= distance
    when :right
        (x+1..x+distance).each { |nx| check.(nx, y) }
        x += distance
    when :left
        (x-distance...x).each { |nx| check.(nx, y) }
        x -= distance
    end
end
