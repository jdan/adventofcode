# since we're keeping state already, we'll just
# loop through once instead of mapping and reducing
enabled = true
total = 0

$stdin.read
  .scan(/mul\((?<a>\d+),(?<b>\d+)\)|(?<do>do\(\))|(?<dont>don't\(\))/)
  .each do |a, b, doit, dont|
    if doit
      enabled = true
    elsif dont
      enabled = false
    elsif a && b && enabled
      total += a.to_i * b.to_i
    end
  end

p total