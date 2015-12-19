# http://adventofcode.com/day/2

total = 0

ARGF.each do |line|
    a, b, c = line.split("x").map(&:to_i).sort

    total +=
        # Surface area
        2*a*b + 2*a*c + 2*b*c +

        # Smallest square - slack
        a*b
end

puts total
