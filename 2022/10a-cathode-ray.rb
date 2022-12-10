lines = $stdin.read.split(/\r?\n/)
cycle = 1
x = 1
total_signal_strength = 0

for line in lines
  if line == "noop"
    cycle += 1
  elsif line =~ /addx/
    cycle += 1
    if cycle % 40 === 20
      total_signal_strength += cycle * x
    end

    x += line.split()[1].to_i
    cycle += 1
  end

  if cycle % 40 === 20
    total_signal_strength += cycle * x
  end
end

puts total_signal_strength
