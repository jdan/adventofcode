ARGF.each do |line|
    a, b, c = line.split("x").map(&:to_i).sort

    total +=
        # Smallest perimeter
        2*a + 2*b +

        # Volume to tie the bow
        a*b*c
end

puts total
