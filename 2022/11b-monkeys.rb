class Monkey
  attr_accessor :items, :test_divisor, :inspections

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

  def process_item(monkeys, global_modulo)
    @inspections += 1
    item = @items.shift
    parts = @operation_str.split(" ")
    worry_level = [
      parts[0] == "old" ? item : parts[0].to_i,
      parts[2] == "old" ? item : parts[2].to_i,
    ].inject(parts[1].to_sym)

    # Worry levels are no longer divided by three after each item is inspected;
    # you'll need to find another way to keep your worry levels manageable.
    # worry_level = worry_level / 3

    # NOTE(jordan): We can find a sufficiently large modulo such that all
    # divisibility and update operations will be sound without the worry levels
    # getting too large.
    worry_level %= global_modulo

    if worry_level % @test_divisor == 0
      monkeys[@target_if_true].items << worry_level
    else
      monkeys[@target_if_false].items << worry_level
    end
  end

  def run(monkeys, global_modulo)
    while @items.any?
      process_item(monkeys, global_modulo)
    end
  end
end

global_modulo = 1
monkeys = $stdin.read.chomp.split(/\r?\n\r?\n/).map do |section|
  m = Monkey.new(section)
  global_modulo *= m.test_divisor
  m
end

def inspect_monkeys(monkeys)
  for i in 0...monkeys.length
    puts "Monkey #{i}: #{monkeys[i].items.join(", ")}"
  end
end

10000.times do
  monkeys.each do |monkey|
    monkey.run(monkeys, global_modulo)
  end
end

# Take the two highest inspection counts and multiply them
inspections = monkeys.map(&:inspections)
puts inspections.sort.reverse[0..1].inject(:*)
