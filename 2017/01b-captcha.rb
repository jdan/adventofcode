stream = gets.chomp.split("").map(&:to_i)

puts stream.each_with_index.map { |num, i|
  num == stream[(i + (stream.size / 2)) % stream.size] ? num : 0
}.inject &:+
