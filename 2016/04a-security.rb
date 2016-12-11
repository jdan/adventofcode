# http://adventofcode.com/2016/day/4

total = 0

ARGF.each do |line|
    match = /([a-z-]+)-(\d+)\[([a-z]+)\]/.match(line)

    if match
        nums = match[1].gsub("-", "")
        id = match[2].to_i
        checksum = match[3]

        checksum = nums
            .split("")
            .group_by { |c| c }
            .to_a
            .sort_by { |entry|
                letter = entry[0]
                freq = entry[1].count

                [-freq, letter]
            }
            .map(&:first)
            .slice(0, 5)
            .join("")

        if gen_checksum == checksum
            total += id
        end
    end
end

puts total