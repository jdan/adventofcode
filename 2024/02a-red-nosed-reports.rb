def safe(floor)
  deltas = floor.each_cons(2).map { |a, b| b - a }
  deltas.all? { |d| d > 0 && d < 4 } || 
    deltas.all? { |d| d < 0 && d > -4 }
end

p $stdin
  .readlines
  .map { |line| line.chomp.split(/\s+/).map(&:to_i) }
  .filter { |floor| safe(floor) }
  .size