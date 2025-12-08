# frozen_string_literal: true

module Solution
  def self.part_a(input)
    junction_boxes = input.lines.map do |line|
      line.chomp.split(',').map(&:to_i)
    end

    # build individual circuits for each junction_box
    circuits = junction_boxes.map { |box| [box, Set.new([box])] }.to_h

    pairs = []
    0.upto(junction_boxes.length - 2) do |a|
      (a + 1).upto(junction_boxes.length - 1) do |b|
        pairs << [junction_boxes[a], junction_boxes[b]]
      end
    end

    closest_pairs = pairs.sort do |a, b|
      distance(*a) - distance(*b)
    end[...1000]

    closest_pairs.each do |pair|
      new_set = circuits[pair[0]] | circuits[pair[1]]

      new_set.each do |box|
        circuits[box] = new_set
      end
    end

    circuits.values.map(&:to_a).uniq.map(&:size).sort[-3..].inject :*
  end

  def self.distance(a, b)
    (a[0] - b[0])**2 + (a[1] - b[1])**2 + (a[2] - b[2])**2
  end

  def self.part_b(input)
    junction_boxes = input.lines.map do |line|
      line.chomp.split(',').map(&:to_i)
    end

    # build individual circuits for each junction_box
    circuits = junction_boxes.map { |box| [box, Set.new([box])] }.to_h

    pairs = []
    0.upto(junction_boxes.length - 2) do |a|
      (a + 1).upto(junction_boxes.length - 1) do |b|
        pairs << [junction_boxes[a], junction_boxes[b]]
      end
    end

    closest_pairs = pairs.sort do |a, b|
      distance(*a) - distance(*b)
    end

    closest_pairs.each do |pair|
      new_set = circuits[pair[0]] | circuits[pair[1]]

      if new_set.size == junction_boxes.size
        # Multiply the x coordinates
        return pair[0][0] * pair[1][0]
      end

      new_set.each do |box|
        circuits[box] = new_set
      end
    end
  end
end

p Solution.part_b $stdin.read
