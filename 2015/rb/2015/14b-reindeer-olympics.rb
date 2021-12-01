# http://adventofcode.com/day/14

Deer = Struct.new(:name, :speed, :stamina, :resting, :points) do
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

    reindeer << Deer.new(match[1], match[2].to_i, match[3].to_i, match[4].to_i, 0)
end

RACE_DISTANCE = 2503

1.upto(RACE_DISTANCE).each do |t|
    standings = reindeer.group_by { |deer| deer.distance_at_time(t) }
    best_distance = standings.keys.max

    standings[best_distance].each do |deer|
        deer.points += 1
    end
end

puts reindeer.map(&:points).max
