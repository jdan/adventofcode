class Monkey
  attr_accessor :items, :inspections

  def initialize(block)
    lines = block.split(/\r?\n/)
    @items = lines[1].split(": ")[1].split(", ").map &:to_i
    @inspections = 0

    # annoying metadata
    @operation_str = lines[2].split(" = ")[1]
    @test_divisor = /(\d+)/.match(lines[3]).captures[0].to_i
    @target_if_true = /(\d+)/.match(lines[4]).captures[0].to_i
    @target_if_false = /(\d+)/.match(lines[5]).captures[0].to_i
  end

  def process_item(monkeys)
    @inspections += 1
    item = @items.shift
    parts = @operation_str.split(" ")
    worry_level = [
      parts[0] == "old" ? item : parts[0].to_i,
      parts[2] == "old" ? item : parts[2].to_i,
    ].inject(parts[1].to_sym)

    # After each monkey inspects an item but before it tests your
    # worry level, your relief that the monkey's inspection didn't
    # damage the item causes your worry level to be divided by
    # three and rounded down to the nearest integer.
    worry_level = worry_level / 3

    if worry_level % @test_divisor == 0
      monkeys[@target_if_true].items << worry_level
    else
      monkeys[@target_if_false].items << worry_level
    end
  end

  def run(monkeys)
    while @items.any?
      process_item(monkeys)
    end
  end
end

monkeys = $stdin.read.chomp.split(/\r?\n\r?\n/).map do |section|
  Monkey.new(section)
end

def inspect_monkeys(monkeys)
  for i in 0...monkeys.length
    puts "Monkey #{i}: #{monkeys[i].items.join(", ")}"
  end
end

20.times do
  monkeys.each do |monkey|
    monkey.run(monkeys)
  end
end

# Take the two highest inspection counts and multiply them
inspections = monkeys.map(&:inspections)
puts inspections.sort.reverse[0..1].inject(:*)
