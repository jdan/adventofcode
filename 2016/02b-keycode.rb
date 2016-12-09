# http://adventofcode.com/2016/day/2

keys = [
    [ nil, nil, '1', nil, nil ],
    [ nil, '2', '3', '4', nil ],
    [ '5', '6', '7', '8', '9' ],
    [ nil, 'A', 'B', 'C', nil ],
    [ nil, nil, 'D', nil, nil ],
]

# Start at 5
x, y = 0, 2

presses = []

ARGF.each do |line|
    line.split("").each do |dir|
        oldx, oldy = x, y

        case dir
        when "U"
            y -= 1
        when "L"
            x -= 1
        when "D"
            y += 1
        when "R"
            x += 1
        end

        # Is this a valid key?
        unless (0...keys.length) === y && (0...keys[y].length) === x && !keys[y][x].nil?
            x, y = oldx, oldy
        end
    end

    presses << keys[y][x]
end

puts presses.join("")