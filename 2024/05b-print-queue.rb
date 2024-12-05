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

def correct(update, ordering_rules)
  update.sort do |a, b|
    matching_rule = ordering_rules.find do |rule|
      rule[0] == a && rule[1] == b || rule[0] == b && rule[1] == a
    end

    if a == matching_rule[0]
      -1
    else
      1
    end
  end
end

p page_updates
  .reject { |update| valid?(update, ordering_rules) }
  .map { |update| correct(update, ordering_rules) }
  .map { |update| update[update.size / 2] }
  .inject :+