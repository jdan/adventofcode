# http://adventofcode.com/day/17

containers = ARGF.map(&:to_i)

EGGNOG_AMT = 150
solutions = 0

# 19 containers, so brute forcing (2^19 = ~500k) isn't too bad
0.upto(2**containers.size - 1).each do |arrangement|
    eggnog = 0

    containers.each do |size|
        # Take
        if arrangement % 2 == 1
            eggnog += size
        end

        # Break early if we've used it all
        break if eggnog > EGGNOG_AMT

        arrangement /= 2
    end

    if eggnog == EGGNOG_AMT
        solutions += 1
    end
end

puts solutions
