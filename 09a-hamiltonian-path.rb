# http://adventofcode.com/day/9

require "set"

graph = Hash.new
cities = Set.new

ARGF.each do |line|
    a, b, dist = line.scan(/(\w+) to (\w+) = (\w+)/)[0]

    cities.add(a)
    cities.add(b)

    graph[a] ||= Hash.new(Float::INFINITY)
    graph[b] ||= Hash.new(Float::INFINITY)

    graph[a][b] = dist.to_i
    graph[b][a] = dist.to_i
end

def path_distance(graph, path)
    distance = 0
    path.each_cons(2) do |a, b|
        graph[a] ||= Hash.new(Float::INFINITY)
        distance += graph[a][b]
    end
    distance
end

puts cities.to_a.permutation.map { |path| path_distance(graph, path) }.min
