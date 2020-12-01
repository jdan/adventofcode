# http://adventofcode.com/day/10

def look_and_say_next(seq)
    build = ""
    last_char = nil
    run_length = 0

    seq.each_char do |char|
        if last_char.nil?
            last_char = char
        end

        if last_char == char
            run_length += 1
        else
            build += run_length.to_s + last_char
            last_char = char
            run_length = 1
        end
    end

    if run_length > 0
        build += run_length.to_s + last_char
    end

    build
end

start = gets.chomp
COUNT = 40

COUNT.times do
    start = look_and_say_next(start)
end

puts start.size
