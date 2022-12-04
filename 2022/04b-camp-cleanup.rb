lines = $stdin.read.split(/\r?\n/)
overlaps = 0
lines.each do |line|
  # extract numbers from the line
  aStart, aEnd, bStart, bEnd = line.scan(/\d+/).map(&:to_i)
  # increment if the ranges overlap
  if aStart <= bEnd && aEnd >= bStart
    overlaps += 1
  end
end

puts overlaps
