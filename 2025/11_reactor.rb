# frozen_string_literal: true

module Solution
  def self.part_a(input)
    graph = parse_graph(input)
    count_paths(graph, 'you', 'out')
  end

  def self.parse_graph(input)
    graph = {}
    input.lines.each do |line|
      device, outputs = line.chomp.split(': ')
      graph[device] = outputs.split(' ')
    end
    graph
  end

  def self.count_paths(graph, current, target, visited = Set.new)
    return 1 if current == target

    visited.add(current)
    count = 0

    (graph[current] || []).each do |neighbor|
      count += count_paths(graph, neighbor, target, visited) unless visited.include?(neighbor)
    end

    visited.delete(current) # backtrack
    count
  end

  def self.part_b(input)
    graph = parse_graph(input)
    paths = find_all_paths(graph, 'svr', 'out')
    paths.count { |path| path.include?('dac') && path.include?('fft') }
  end

  def self.find_all_paths(graph, current, target, visited = Set.new, path = [])
    path = path + [current]

    if current == target
      return [path]
    end

    visited.add(current)
    all_paths = []

    (graph[current] || []).each do |neighbor|
      unless visited.include?(neighbor)
        all_paths += find_all_paths(graph, neighbor, target, visited, path)
      end
    end

    visited.delete(current) # backtrack
    all_paths
  end
end

# p Solution.part_a $stdin.read
p Solution.part_b $stdin.read
