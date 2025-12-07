# frozen_string_literal: true

module Solution
  def self.part_a(input)
    splits = 0
    beams = input.lines.first.gsub(/S/, '|').split ''

    input.lines[1..].each do |line|
      line.chomp.length.times do |idx|
        # split the beam
        next unless line[idx] == '^' && beams[idx] == '|'

        splits += 1
        beams[idx] = '.'
        beams[idx - 1] = '|' if idx > 0
        beams[idx + 1] = '|' if idx < beams.length - 1
      end
    end

    splits
  end

  def self.part_b(input)
    # We're no longer storing as a string, but counting
    # the number of beams which pass through this point
    quantum_beams = [0] * input.lines.first.chomp.length
    quantum_beams[input.lines.first.index 'S'] = 1

    input.lines[1..].each do |line|
      line.chomp.length.times do |idx|
        # split the beam
        next unless line[idx] == '^' && quantum_beams[idx] > 0

        prev_value = quantum_beams[idx]
        # A little dynamic programming never hurt anyone
        quantum_beams[idx] = 0
        quantum_beams[idx - 1] += prev_value if idx > 0
        quantum_beams[idx + 1] += prev_value if idx < quantum_beams.length - 1
      end
    end

    quantum_beams.sum
  end
end

p Solution.part_b $stdin.read
