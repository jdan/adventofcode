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

    # Assume the graph is a DAG and use DP
    # Count paths from svr to out with both dac and fft visited
    memo = {}
    count_paths_dag(graph, 'svr', 'out', false, false, memo)
  end

  def self.count_paths_dag(graph, current, target, seen_dac, seen_fft, memo)
    # Update if we've seen dac or fft
    seen_dac = true if current == 'dac'
    seen_fft = true if current == 'fft'

    # If we reached the target, count this path only if we've seen both
    return (seen_dac && seen_fft) ? 1 : 0 if current == target

    # Memoization key (works if graph is a DAG - no cycles)
    memo_key = [current, seen_dac, seen_fft]
    return memo[memo_key] if memo.key?(memo_key)

    count = 0
    (graph[current] || []).each do |neighbor|
      count += count_paths_dag(graph, neighbor, target, seen_dac, seen_fft, memo)
    end

    memo[memo_key] = count
    count
  end
end

# p Solution.part_a $stdin.read
p Solution.part_b $stdin.read
