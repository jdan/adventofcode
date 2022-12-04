lines = $stdin.read.split(/\r?\n/)
# chunk into groups of 3
groups = lines.each_slice(3).to_a

total = 0

# find the character that appears in all 3 lines
groups.each do |group|
  group[0].chars.each do |char|
    if group[1].include?(char) && group[2].include?(char)
      # encode char from 1-26 if a-z and 27-52 if A-Z
      if char =~ /[a-z]/
        total += char.ord - 96
      else
        total += char.ord - 38
      end
      break
    end
  end
end

puts total
