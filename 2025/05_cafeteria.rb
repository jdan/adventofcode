# frozen_string_literal: true

module Solution
  def self.part_a(input)
    ranges, ids = parse_input(input)

    ids.count { |id| is_fresh?(ranges, id) }
  end

  def self.part_b(input)
    ranges, = parse_input(input)

    set = RangeSet.new

    ranges.each do |range_input|
      range = MyRange.new(*range_input)
      set << range
    end

    set.size
  end

  def self.is_fresh?(ranges, id)
    ranges.any? do |range|
      id >= range[0] && id <= range[1]
    end
  end

  def self.parse_input(input)
    range_part, id_part = input.split("\n\n")
    ranges = range_part.lines.map do |line|
      a, b = line.chomp.split('-')
      [a.to_i, b.to_i]
    end

    ids = id_part.lines.map do |line|
      line.chomp.to_i
    end

    [ranges, ids]
  end
end

class RangeSet
  def initialize
    @ranges = []
  end

  # essentially a modified insertion sort
  #
  # this will be O(n^2) but optimizations are possible
  # to make it O(n)
  def <<(range)
    @ranges.each_with_index do |item, index|
      new_range = range.combine(item)

      if new_range
        # splice out the current index and go back to the beginning
        # FOOTGUN: @ranges.delete(...)
        @ranges.delete_at(index)
        self << new_range
        return
      end

      # if the range is fully less than the one we're comparing
      # against, just insert it
      if range.b < item.a
        @ranges.insert(index, range)
        return
      end
    end

    @ranges << range
  end

  def size
    @ranges.map { |range| range.b - range.a + 1 }.sum
  end
end

# FOOTGUN: Range.new :(
class MyRange
  attr_accessor :a, :b

  # a < b
  def initialize(a, b)
    @a = a
    @b = b
  end

  def combine(other)
    # we are fully-contained within other
    return other if other.a <= @a and other.b >= @b

    # other is fully-contained within us
    return self if @a <= other.a and @b >= other.b

    # the start is within other and extends out
    return MyRange.new(other.a, @b) if @a >= other.a and @a <= other.b

    # the end is within other and extends out
    return MyRange.new(@a, other.b) if @b >= other.a and @b <= other.b

    # the ranges don't combine
    nil
  end
end

p Solution.part_b $stdin.read
