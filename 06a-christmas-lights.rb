# http://adventofcode.com/day/6

lights = Array.new(1000) {
    Array.new(1000, false)
}

def over_square(a, b, x, y, &block)
    a.upto(x) do |i|
        b.upto(y) do |j|
            block.call(i, j)
        end
    end
end

ARGF.each do |line|
    scan = line.match /(.+) (\d+),(\d+) through (\d+),(\d+)/

    command = scan[1]
    a, b = scan[2].to_i, scan[3].to_i
    x, y = scan[4].to_i, scan[5].to_i

    case command
    when "turn on"
        over_square(a, b, x, y) do |i, j|
            lights[i][j] = true
        end
    when "turn off"
        over_square(a, b, x, y) do |i, j|
            lights[i][j] = false
        end
    when "toggle"
        over_square(a, b, x, y) do |i, j|
            lights[i][j] = !lights[i][j]
        end
    end
end

total = 0
over_square(0, 0, 999, 999) do |i, j|
    if lights[i][j]
        total += 1
    end
end

puts total
