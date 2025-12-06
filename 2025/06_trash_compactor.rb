# frozen_string_literal: true

module Solution
  def self.part_a(input)
    grid = input.lines.map do |line|
      line.strip.split(/\s+/)
    end

    problems = grid[...-1].transpose
    operators = grid[-1]

    problems.each_with_index.map do |row, index|
      row.map(&:to_i).inject(operators[index].to_sym)
    end.sum
  end

  def self.part_b(input)
    operators = input.lines[-1].split(/\s+/)
    # indices of the operators
    column_starts = input.lines[-1]
                         .enum_for(:scan, /[^\s]/)
                         .map { Regexp.last_match.begin(0) }

    problems = []
    current_problem = []
    0.upto(input.lines.first.chomp.length - 1) do |column|
      if column_starts.index(column + 1)
        problems << current_problem
        current_problem = []
        next
      end

      current_problem << input.lines[...-1].map do |line|
        line[column]
      end.join.to_i
    end

    problems << current_problem

    problems.each_with_index.map do |problem, index|
      problem.inject(operators[index].to_sym)
    end.sum
  end
end

p Solution.part_b $stdin.read
