# http://adventofcode.com/day/17

containers = ARGF.map(&:to_i)

EGGNOG_AMT = 150
solutions = []

# 19 containers, so brute forcing (2^19 = ~500k) isn't too bad
0.upto(2**containers.size - 1).each do |arrangement|
    eggnog = 0
    num_containers = 0

    containers.each do |size|
        # Take
        if arrangement % 2 == 1
            eggnog += size
            num_containers += 1
        end

        # Break early if we've used it all
        break if eggnog > EGGNOG_AMT

        arrangement /= 2
    end

    if eggnog == EGGNOG_AMT
        solutions << num_containers
    end
end

# Find the minimum number of containers that can exactly fit all 150 liters of
# eggnog. How many different ways can you fill that number of containers?

# group_by is pretty cool. We'll group the solutions (represented by the
# number of containers) and output how many solutions take up the least
# amount of containers (whatever it is)
grouped = solutions.group_by { |i| i }
puts grouped[grouped.keys.min].size
