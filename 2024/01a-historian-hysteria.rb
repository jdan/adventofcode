p $stdin
  .readlines
  .map { |line| line.chomp.split(/\s+/).map(&:to_i) }
  .transpose
  .map { |a| a.sort }
  .transpose
  .map { |p| (p[0] - p[1]).abs }
  .sum
