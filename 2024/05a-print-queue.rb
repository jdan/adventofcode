orders, updates = $stdin.read.split "\n\n"

ordering_rules = orders.split("\n").map do |line|
  line.split("|").map(&:to_i)
end

page_updates = updates.split("\n").map do |line|
  line.split(",").map(&:to_i)
end

def valid?(update, ordering_rules)
  ordering_rules.all? do |rule|
    a, b = rule
    a_i = update.index(a)
    b_i = update.index(b)
    
    if a_i && b_i
      a_i < b_i
    else
      true
    end
  end
end

p page_updates
  .filter { |update| valid?(update, ordering_rules) }
  .map { |update| update[update.size / 2] }
  .inject :+