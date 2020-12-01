# http://adventofcode.com/2016/day/4

ARGF.each do |line|
    match = /([a-z-]+[a-z])-(\d+)\[([a-z]+)\]/.match(line)

    if match
        name = match[1]
        id = match[2].to_i
        checksum = match[3]

        gen_checksum = name
            .gsub("-", "")
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
            decrypted = name
                .split("")
                .map { |c|
                    if c == "-"
                        " "
                    else
                        # Shift the character
                        ((c.ord - 97 + id) % 26 + 97).chr
                    end
                }
                .join("")

            # Scan for the string "northpole" and output
            # the sector ID if there's a match
            if /northpole/ === decrypted
                puts id
            end
        end
    end
end
