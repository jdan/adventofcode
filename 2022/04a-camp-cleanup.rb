lines = $stdin.read.split(/\r?\n/)
overlaps = 0
lines.each do |line|
  # extract numbers from the line
  aStart, aEnd, bStart, bEnd = line.scan(/\d+/).map(&:to_i)
  # increment if one of the ranges fully contains the other
  if aStart <= bStart && aEnd >= bEnd || bStart <= aStart && bEnd >= aEnd
    overlaps += 1
  end
end

puts overlaps
