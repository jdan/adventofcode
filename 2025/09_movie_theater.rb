# frozen_string_literal: true

module Solution
  def self.part_a(input)
    tiles = input.lines.map do |line|
      line.chomp.split(',').map(&:to_i)
    end

    max_area = 0
    0.upto(tiles.length - 2) do |a|
      a.upto(tiles.length - 1) do |b|
        dx = (tiles[a][0] - tiles[b][0]).abs + 1
        dy = (tiles[a][1] - tiles[b][1]).abs + 1
        max_area = [max_area, dx * dy].max
      end
    end

    max_area
  end

  ##
  # Needed claude to help me debug :(
  # Had _roughly_ the right approach but my raycasting was busted
  def self.part_b(input)
    # Parse red tiles
    red_tiles = input.lines.map { |line| line.chomp.split(',').map(&:to_i) }

    # Build polygon edges (connecting consecutive red tiles)
    edges = []
    red_tiles.each_with_index do |tile, i|
      next_tile = red_tiles[(i + 1) % red_tiles.length]
      edges << [tile, next_tile]
    end

    max_area = 0
    best_rect = nil

    # Try all pairs of red tiles as opposite corners
    red_tiles.each_with_index do |tile_a, i|
      red_tiles.each_with_index do |tile_b, j|
        next if i >= j # Avoid duplicates

        x1, y1 = tile_a
        x2, y2 = tile_b

        x_min, x_max = [x1, x2].sort
        y_min, y_max = [y1, y2].sort

        # Check if this rectangle is valid (entirely within the polygon)
        next unless rectangle_inside_polygon?(x_min, x_max, y_min, y_max, edges)

        area = (x_max - x_min + 1) * (y_max - y_min + 1)
        if area > max_area
          max_area = area
          best_rect = [x_min, x_max, y_min, y_max]
        end
      end
    end

    max_area
  end

  def self.rectangle_inside_polygon?(x_min, x_max, y_min, y_max, edges)
    # Strategy: Sample points along perimeter and check no edges cross through

    # Sample points along each edge of the rectangle
    sample_count = 20
    dx = x_max - x_min
    dy = y_max - y_min

    # Generate sample points along perimeter
    points_to_check = []

    # Top and bottom edges
    (0..sample_count).each do |i|
      x = x_min + (dx * i) / sample_count
      points_to_check << [x, y_min]
      points_to_check << [x, y_max]
    end

    # Left and right edges (skip corners already in top/bottom)
    (1...sample_count).each do |i|
      y = y_min + (dy * i) / sample_count
      points_to_check << [x_min, y]
      points_to_check << [x_max, y]
    end

    # Check all sampled points are inside or on polygon
    points_to_check.each do |x, y|
      return false unless point_in_or_on_polygon?(x, y, edges)
    end

    # Check that no polygon edge crosses through the rectangle interior
    edges.each do |edge|
      p1, p2 = edge
      x1, y1 = p1
      x2, y2 = p2

      # Skip if edge is entirely outside rectangle bounds
      next if [x1, x2].max < x_min || [x1, x2].min > x_max
      next if [y1, y2].max < y_min || [y1, y2].min > y_max

      # If edge is vertical
      if x1 == x2
        # Check if it crosses through the rectangle interior (not on boundary)
        if x1 > x_min && x1 < x_max
          seg_y_min, seg_y_max = [y1, y2].sort
          # If it overlaps with rectangle's y-range, it crosses through
          return false if seg_y_max > y_min && seg_y_min < y_max
        end
      # If edge is horizontal
      elsif y1 == y2
        # Check if it crosses through the rectangle interior (not on boundary)
        if y1 > y_min && y1 < y_max
          seg_x_min, seg_x_max = [x1, x2].sort
          # If it overlaps with rectangle's x-range, it crosses through
          return false if seg_x_max > x_min && seg_x_min < x_max
        end
      end
    end

    true
  end

  def self.point_in_or_on_polygon?(x, y, edges)
    # First check if point is on any edge
    edges.each do |edge|
      p1, p2 = edge
      x1, y1 = p1
      x2, y2 = p2

      # Check if point is on this edge
      if x1 == x2 && x == x1 # Vertical edge
        return true if y >= [y1, y2].min && y <= [y1, y2].max
      elsif y1 == y2 && y == y1 # Horizontal edge
        return true if x >= [x1, x2].min && x <= [x1, x2].max
      end
    end

    # Use ray casting to check if inside
    # Count crossings to the right
    crossings = 0
    edges.each do |edge|
      p1, p2 = edge
      x1, y1 = p1
      x2, y2 = p2

      # Only count vertical edges to the right of point
      next unless x1 == x2 && x1 > x

      y_min, y_max = [y1, y2].sort
      # Use half-open interval [y_min, y_max) to handle endpoints consistently
      crossings += 1 if y >= y_min && y < y_max
    end

    crossings.odd?
  end
end

puts Solution.part_b $stdin.read
