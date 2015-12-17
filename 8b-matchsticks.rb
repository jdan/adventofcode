total = 0

ARGF.each do |line|
    orig_length = line.size
    modify_length = line
        .gsub("\\", "__") # \ becomes two characters
        .gsub('"', "__")  # " becomes two characters
        .size + 2

    total += modify_length - orig_length
end

puts total
