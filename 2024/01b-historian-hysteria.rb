left, right = $stdin
  .readlines
  .map { |line| line.chomp.split(/\s+/).map(&:to_i) }
  .transpose

counts = right.group_by(&:itself).transform_values(&:count)

p left.sum { |l| l * (counts[l] || 0) }
