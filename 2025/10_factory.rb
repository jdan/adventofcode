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

  ##
  # Done with Claude Code and the GLPK library
  # https://www.gnu.org/software/glpk/
  #
  # I knew I needed linear programming but not interested in learning it
  def self.part_b(input)
    input.lines.map { |line| min_presses_joltage(line.chomp) }.sum
  end

  def self.min_presses_joltage(line)
    require 'tempfile'

    # Extract buttons and joltage requirements
    match = /(\(.+\) )+\{(.+)\}/.match(line)
    buttons_str = match[1].strip
    joltage_str = match[2]

    # Parse buttons: each button is a list of counter indices
    buttons = buttons_str.split(' ').map do |schematic|
      schematic[1...-1].split(',').map(&:to_i)
    end

    # Parse target joltage levels
    target = joltage_str.split(',').map(&:to_i)

    num_buttons = buttons.length
    num_counters = target.length

    # Create CPLEX LP format file
    Tempfile.create(['problem', '.lp']) do |lp_file|
      # Write objective
      lp_file.puts 'Minimize'
      lp_file.puts ' obj: ' + (0...num_buttons).map { |i| "x#{i}" }.join(' + ')

      # Write constraints
      lp_file.puts 'Subject To'
      num_counters.times do |counter_idx|
        # Find which buttons affect this counter
        coeffs = num_buttons.times.map do |button_idx|
          buttons[button_idx].include?(counter_idx) ? "x#{button_idx}" : nil
        end.compact

        lp_file.puts " c#{counter_idx}: #{coeffs.join(' + ')} = #{target[counter_idx]}" if coeffs.any?
      end

      # Write bounds (all variables are non-negative integers)
      lp_file.puts 'Bounds'
      num_buttons.times do |i|
        lp_file.puts " 0 <= x#{i}"
      end

      # Declare integer variables
      lp_file.puts 'General'
      lp_file.puts ' ' + (0...num_buttons).map { |i| "x#{i}" }.join(' ')

      lp_file.puts 'End'
      lp_file.flush

      # Solve using glpsol
      output = `glpsol --lp #{lp_file.path} --output /dev/stdout 2>/dev/null`

      # Parse the objective value from output
      return match[1].to_f.round if match = output.match(/Objective:\s+obj\s+=\s+(\d+(?:\.\d+)?)/m)

      raise "Failed to solve: #{output}"
    end
  end
end

# p Solution.part_a $stdin.read
p Solution.part_b $stdin.read
