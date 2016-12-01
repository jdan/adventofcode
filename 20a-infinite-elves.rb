# http://adventofcode.com/day/20

target = ARGF.first.to_i

def presents(n)
    # This is equivalent to 10 times the sum of a number's prime factors,
    # and itself
    sqrt = Math.sqrt(n)
    is_square = (sqrt == sqrt.to_i)

    upto = is_square ? sqrt.to_i - 1 : sqrt.to_i

    sum = 10 * 1.upto(upto).map { |i|
        if n % i == 0
            i + n / i
        else
            0
        end
    }.inject(&:+)

    if is_square
        sum + 10 * sqrt.to_i
    else
        sum
    end
end

puts presents(2**30)

# house = 300000
# while presents(house) < target
#     puts house
#     house += 1
# end

# puts house
