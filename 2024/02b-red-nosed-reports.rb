class Array
  def without_nth(n)
    self[0...n] + self[n+1..-1]
  end
end

def safe(floor)
  (0...floor.size).any? do |idx|
    deltas = floor.without_nth(idx).each_cons(2).map { |a, b| b - a }
    deltas.all? { |d| d > 0 && d < 4 } || 
      deltas.all? { |d| d < 0 && d > -4 }
  end
end

p $stdin
  .readlines
  .map { |line| line.chomp.split(/\s+/).map(&:to_i) }
  .filter { |floor| safe(floor) }
  .size