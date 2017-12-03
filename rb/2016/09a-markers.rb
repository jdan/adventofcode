# http://adventofcode.com/2016/day/9

input = gets.chomp
output = ""
i = 0

while i < input.length do
    if /^\((\d+)x(\d+)\)/ =~ input[i..-1]
        marker = $~[0]

        # Shift i past the marker
        i += marker.length

        # Extract the characters to copy, and the count
        to_copy = input.slice(i, $1.to_i)
        count = $2.to_i

        # Adjust the output
        output += to_copy * count

        # Shift i past the characters that were copied
        i += to_copy.length
    else
        # Add a single character
        output += input[i]
        i += 1
    end
end

puts output.length
