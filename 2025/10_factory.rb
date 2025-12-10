# frozen_string_literal: true

module Solution
  def self.part_a(input)
    input.lines.map { |line| min_presses(line.chomp) }.sum
  end

  def self.min_presses(line)
    lights_re, buttons_re = /\[([.#]+)\] (\(.+\) )+/.match(line).captures

    lights = lights_of_str(lights_re)
    buttons = buttons_of_str(buttons_re.strip)

    # which buttons, when xor'd, result in lights?
    0.upto(2**buttons.length - 1) do |n|
      # we'll be increasing in length, so we can bail as soon
      # as we find one
      buttons.combination(n) do |subset|
        return subset.length if lights == subset.inject(:^)
      end
    end
  end

  def self.lights_of_str(str)
    str.chars.each_with_index.map do |char, idx|
      2**idx * (char == '#' ? 1 : 0)
    end.sum
  end

  def self.buttons_of_str(str)
    str.split(' ').map do |schematic|
      schematic[1...-1].split(',').map do |idx|
        2**idx.to_i
      end.sum
    end
  end

  def self.part_b(input)
    buttons_re, joltage_re = /(\(.+\) )+(\{.+\})/.match(line).captures
  end
end

p Solution.part_a $stdin.read
