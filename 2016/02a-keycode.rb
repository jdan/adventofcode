# http://adventofcode.com/2016/day/2

keys = [
    [ 1, 2, 3 ],
    [ 4, 5, 6 ],
    [ 7, 8, 9 ],
]

# Start at 5
x, y = 1, 1

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
        unless (0...keys.length) === y && (0...keys[y].length) === x
            x, y = oldx, oldy
        end
    end

    presses << keys[y][x]
end

puts presses.join("")