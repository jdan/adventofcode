# http://adventofcode.com/day/5

total = 0

ARGF.each do |line|
    next if line =~ /(ab|cd|pq|xy)/

    if line.scan(/[aeiou]/).size >= 3 and line =~ /(.)\1/
        total += 1
    end
end

puts total
