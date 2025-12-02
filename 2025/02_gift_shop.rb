# frozen_string_literal: true

module Solution
  def self.part_a(input)
    input.split(',').map { |range| sum_invalid_in_range_a(range) }.sum
  end

  def self.sum_invalid_in_range_a(range)
    a, b = range.split('-').map(&:to_i)
    sum_invalid = 0
    a.upto(b) do |num|
      str = num.to_s
      next unless str.length.even?

      sum_invalid += num if str[0...str.length / 2] == str[str.length / 2..]
    end
    sum_invalid
  end

  def self.part_b(input)
    input.split(',').map { |range| sum_invalid_in_range_b(range) }.sum
  end

  def self.sum_invalid_in_range_b(range)
    a, b = range.split('-').map(&:to_i)
    sum_invalid = 0
    a.upto(b) do |num|
      str = num.to_s

      # Divide the string into parts: 2222 -> 22 22
      1.upto(str.length / 2) do |length|
        next unless str.length % length == 0

        parts = str.chars.each_slice(length).to_a

        # Are all parts equal?
        next unless parts.all? { |part| part == parts[0] }

        sum_invalid += num

        # Don't double-count numbers like 222222
        break
      end
    end
    sum_invalid
  end
end

puts Solution.part_b $stdin.read
