lines = $stdin.read.split(/\r?\n/)
cycle = 1
x = 1

print '#'

for line in lines
  if line == "noop"
    cycle += 1
  elsif line =~ /addx/
    cycle += 1
    # draw
    print ((cycle - 1) % 40 - x).abs <= 1 ? '#' : '.'
    print "\n" if cycle % 40 == 0

    x += line.split()[1].to_i
    cycle += 1
  end

  # draw
  print ((cycle - 1) % 40 - x).abs <= 1 ? '#' : '.'
  print "\n" if cycle % 40 == 0
end
