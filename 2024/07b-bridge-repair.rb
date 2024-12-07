test_data = <<DATA
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
DATA

class Numeric
  def cat(other)
    (self.to_s + other.to_s).to_i
  end
end

def possible?(goal, ns)
  # loop through all possible combinations of (n-1) :+'s, :*'s, or :cat's
  [:+, :*, :cat].repeated_permutation(ns.size - 1).any? do |ops|
    goal == ns.reduce { |acc, n| acc.send(ops.shift, n) }
  end
end

def parse_line(line)
  goal_, ns_ = line.split(': ')
  
  goal = goal_.to_i
  ns = ns_.split(' ').map(&:to_i)

  [goal, ns]
end

p $stdin.read
  .split("\n")
  .map { |line| parse_line(line) }
  .filter { |line|
    goal, ns = line
    possible?(goal, ns)
  }
  .inject(0) { |acc, line|
    acc + line[0]
  } 