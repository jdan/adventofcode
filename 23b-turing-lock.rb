state = {
    # Definitely not to distract you, what is the value in register b after
    # the program is finished executing if register a starts as 1 instead?
    a: 1,
    b: 0,
    counter: 0,
    instructions: []
}

# Extract the register from an instruction
def reg(line)
    line.split(" ")[1].to_sym
end

# Extra the value from an instruction
def value(line)
    line.split(" ")[1].to_i
end

ARGF.each do |line|
    state[:instructions] << case line
        when /hlf/
            -> { state[reg(line)] /= 2 }
        when /tpl/
            -> { state[reg(line)] *= 3 }
        when /inc/
            -> { state[reg(line)] += 1 }
        when /jmp/
            -> {
                # Increment the counter (minus 1 because we'll inc it after)
                state[:counter] += value(line) - 1
            }
        when /jie/
            -> {
                match = line.match /(a|b), (.*)/
                reg = match[1].to_sym
                offset = match[2].to_i

                if state[reg].even?
                    state[:counter] += offset - 1
                end
            }
        when /jio/
            -> {
                match = line.match /(a|b), (.*)/
                reg = match[1].to_sym
                offset = match[2].to_i

                if state[reg] == 1
                    state[:counter] += offset - 1
                end
            }
        end
end

while state[:counter] < state[:instructions].count
    state[:instructions][state[:counter]].()
    state[:counter] += 1
end

# What is the value in register b when the program in your puzzle input is
# finished executing?
puts state[:b]
