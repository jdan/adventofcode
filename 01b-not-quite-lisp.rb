parens = gets.chomp
floor = 0

parens.split("").each_with_index do |char, i|
    if char == "("
        floor += 1
    elsif char == ")"
        floor -= 1
    end

    # Output the position where we enter the basement
    if floor == -1
        puts i + 1
        break
    end
end
