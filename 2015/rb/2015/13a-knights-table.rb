# http://adventofcode.com/day/13

seating = {}
people = []

ARGF.each do |line|
    re = /(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+)/
    match = line.match(re)

    a = match[1]
    b = match[4]

    # Track the different people
    people << a

    sign = match[2] == "gain" ? 1 : -1
    points = sign * match[3].to_i

    # Store the points
    seating["#{a},#{b}"] = points
end

puts people.uniq.permutation.map { |group|
    # Add the first and second person to the end so we can "cycle" groups of
    # three with each_cons
    group << group[0] << group[1]

    total = 0
    group.each_cons(3) do |trio|
        # Points looking left
        total += seating["#{trio[1]},#{trio[0]}"]

        # Points looking right
        total += seating["#{trio[1]},#{trio[2]}"]
    end

    total
}.max
