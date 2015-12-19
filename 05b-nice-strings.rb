total = 0

ARGF.each do |line|
    # XY_____XY
    # and
    # X_X
    if line =~ /(.)(.).*\1\2/ and line =~ /(.).\1/
        total += 1
    end
end

puts total
