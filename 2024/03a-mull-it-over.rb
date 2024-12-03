# scan for mul(\d+,\d+) and extract the two numbers
# then multiply them together
p $stdin.read
  .scan(/mul\((\d+),(\d+)\)/)
  .map { |a,b| a.to_i * b.to_i }
  .inject :+