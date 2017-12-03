# http://adventofcode.com/day/14

Deer = Struct.new(:name, :speed, :stamina, :resting) do
    def distance_at_time(time)
        time_left = time % (stamina + resting)

        if time_left < stamina
            extra_distance = speed * time_left
        else
            extra_distance = speed * stamina
        end

        cycles = time / (stamina + resting)
        distance = cycles * (speed * stamina)

        distance + extra_distance
    end
end

reindeer = []

ARGF.each do |line|
    re = /(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+)/
    match = line.match(re)

    reindeer << Deer.new(match[1], match[2].to_i, match[3].to_i, match[4].to_i)
end

RACE_DISTANCE = 2503

puts reindeer
    .map { |deer| deer.distance_at_time(RACE_DISTANCE) }
    .max
