# frozen_string_literal: true

module Solution
  def self.part_a(input)
    input.lines.map { |line| max_joltage_pair(line.chomp) }.sum
  end

  def self.max_joltage_pair(bank)
    max = 0
    0.upto(bank.length - 2) do |i|
      (i + 1).upto(bank.length - 1) do |j|
        joltage = 10 * bank[i].to_i + bank[j].to_i
        max = joltage if joltage > max
      end
    end
    max
  end

  def self.part_b(input)
    input.lines.map { |line| max_joltage_dozen(line.chomp) }.sum
  end

  def self.max_joltage_dozen(bank)
    max_joltage = 0
    idx = 0
    # TODO: Can generalize this 12 as an argument to rewrite part A
    12.times do |n|
      # which batteries are available to turn on, leaving enough room
      # for further iteration
      # off-by-one incoming...
      available = bank[idx...bank.length - (12 - n - 1)].split('')

      # what's the maximum?
      max = available.max_by(&:to_i)

      # set the new index
      idx += available.index(max) + 1

      # add this digit to the joltage
      max_joltage = max_joltage * 10 + max.to_i
    end

    max_joltage
  end
end

puts Solution.part_b $stdin.read
