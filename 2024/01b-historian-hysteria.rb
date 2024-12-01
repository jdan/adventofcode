left, right = $stdin
  .readlines
  .map { |line| line.chomp.split(/\s+/).map(&:to_i) }
  .transpose

counts = right.tally

p left.sum { |l| l * (counts[l] || 0) }
