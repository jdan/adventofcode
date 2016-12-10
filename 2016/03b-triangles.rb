# http://adventofcode.com/2016/day/3

possible = 0

ARGF.each_slice(3) do |lines|
    # Take 3 lines and make a 3x3 array
    lines.map! { |line| line.scan(/\d+/).map(&:to_i) }

    # Now take the three columns and make three rows
    0.upto(2) do |col|
        if (lines[0][col] + lines[1][col] > lines[2][col]) &&
                (lines[1][col] + lines[2][col] > lines[0][col]) &&
                (lines[2][col] + lines[0][col] > lines[1][col])
            possible += 1
        end
    end
end

puts possible