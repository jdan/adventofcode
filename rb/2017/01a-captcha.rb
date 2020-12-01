stream = gets.chomp.split("").map(&:to_i)

puts stream.each_with_index.map { |num, i|
  num == stream[i-1] ? num : 0
}.inject &:+
