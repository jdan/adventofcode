# http://adventofcode.com/2016/day/7

has_abba = ->(s) {
    # ABBA, B != A
    s =~ /(\w)(?!\1)(\w)\2\1/
}

hypernet_sequences = ->(s) {
    s.scan(/\[(\w+)\]/).flatten
}

total = 0

ARGF.each do |line|
    if has_abba.(line)
        # Skip if any hypernet sequences have an ABBA
        unless hypernet_sequences.(line).any? { |seq| has_abba.(seq) }
            total += 1
        end
    end
end

puts total
