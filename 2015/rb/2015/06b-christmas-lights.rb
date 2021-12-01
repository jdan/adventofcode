# http://adventofcode.com/day/6

lights = Array.new(1000) {
    Array.new(1000, 0)
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
            lights[i][j] += 1
        end
    when "turn off"
        over_square(a, b, x, y) do |i, j|
            lights[i][j] -= 1

            if lights[i][j] < 0
                lights[i][j] = 0
            end
        end
    when "toggle"
        over_square(a, b, x, y) do |i, j|
            lights[i][j] += 2
        end
    end
end

total = 0
over_square(0, 0, 999, 999) do |i, j|
    total += lights[i][j]
end

puts total
