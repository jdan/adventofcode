# http://adventofcode.com/2016/day/9

def decompressed_length(str)
    length = 0
    i = 0

    $marker_re = /^\((\d+)x(\d+)\)/

    while i < str.length do
        if $marker_re =~ str[i..-1]
            marker = $~[0]

            # Shift i past the marker
            i += marker.length

            # Extract the characters to copy, and the count
            to_copy = str.slice(i, $1.to_i)
            count = $2.to_i

            # Compute the length of characters added
            length += count * decompressed_length(to_copy)

            # Shift i past the characters that were copied
            i += to_copy.length
        else
            length += 1
            i += 1
        end
    end

    length
end

puts decompressed_length(gets.chomp)
