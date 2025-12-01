# frozen_string_literal: true

##
# Day 1
module Solution
  def self.part_a(input)
    dial = 50
    zeroes = 0
    input.lines.each do |line|
      direction, amount = line.match(/([LR])(\d+)/).captures
      dial += amount.to_i * (direction == 'R' ? 1 : -1)
      dial %= 100

      zeroes += 1 if dial.zero?
    end
    zeroes
  end

  def self.part_b(input)
    dial = 50
    crossings = 0
    input.lines.each do |line|
      direction, amount = line.match(/([LR])(\d+)/).captures
      amount = amount.to_i

      if direction == 'R'
        crossings += amount / 100
        crossings += 1 if dial + (amount % 100) >= 100

        dial = (dial + amount) % 100
      else
        crossings += amount / 100
        # crossings += 1 if (dial - (amount % 100)) <= 0
        crossings += 1 if dial.positive? && dial <= (amount % 100)

        dial = (dial - amount) % 100
      end
    end

    crossings
  end

  def self.part_b_slow(input)
    dial = 50
    crossings = 0
    input.lines.each do |line|
      direction, amount = line.match(/([LR])(\d+)/).captures
      amount = amount.to_i

      if direction == 'R'
        amount.times do
          dial += 1
          crossings += 1 if dial == 100

          dial %= 100
        end
      else
        amount.times do
          dial -= 1
          crossings += 1 if dial.zero?

          dial %= 100
        end
      end
    end

    crossings
  end
end

puts Solution.part_b($stdin.read)
