puts ARGF.map { |line|
  list = line.chomp.split.map &:to_i
  list.max - list.min
}.inject :+
