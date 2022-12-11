stack_diagram, instructions = $stdin.read.split(/\r?\n\r?\n/)
diagram_lines = stack_diagram.split(/\r?\n/)

# remove the labels
diagram_lines.pop

# parse diagram
num_stacks = (diagram_lines[-1].length / 4.0).ceil
stacks = (0...num_stacks).map do |i|
  diagram_lines.map { |line|
    line[i*4 + 1]
  }.join('').strip.split('').reverse
end

instructions.split(/\r?\n/).each do |instruction|
  # move 1 from 2 to 1
  count, source, destination = /move (\d+) from (\d+) to (\d+)/.match(instruction).captures
  count.to_i.times do
    stacks[destination.to_i - 1] << (stacks[source.to_i - 1].pop)
  end
end

puts stacks.map { |stack| stack[-1] }.join('')
