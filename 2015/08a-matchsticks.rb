# http://adventofcode.com/day/8

total = 0

ARGF.each do |line|
    orig_length = line.size
    modify_length = line
        .gsub(/\\\\/, "_")
        .gsub(/\\"/, "_")
        .gsub(/\\x[A-Fa-f0-9]{2}/, "_")
        .size - 2

    total += orig_length - modify_length
end

puts total
