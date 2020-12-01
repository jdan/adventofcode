# http://adventofcode.com/2016/day/8

def blank_screen(width, height)
    (0...height).map { |r| [0]*width }
end

def print_screen(screen)
    screen.each do |row|
        puts row.map { |i| i == 1 ? "#" : "." }.join("")
    end
end

def rect(screen, a, b)
    (0...b).each do |row|
        (0...a).each do |col|
            screen[row][col] = 1
        end
    end

    screen
end

def rotate_row(screen, row, amt)
    screen[row].rotate!(-amt)
    screen
end

def rotate_col(screen, col, amt)
    column = screen.map { |row| row[col] }
    column.rotate!(-amt)
    screen.map.with_index { |row, i|
        row[col] = column[i]
        row
    }
    screen
end

def pixel_count(screen)
    screen.map { |row|
        row.select { |i| i == 1 }.count
    }.reduce :+
end

s = blank_screen(50, 6)

ARGF.each do |instruction|
    case instruction
    when /rect (\d+)x(\d+)/
        s = rect(s, $1.to_i, $2.to_i)
    when /rotate column x=(\d+) by (\d+)/
        s = rotate_col(s, $1.to_i, $2.to_i)
    when /rotate row y=(\d+) by (\d+)/
        s = rotate_row(s, $1.to_i, $2.to_i)
    end
end

print_screen(s)
puts pixel_count(s)
