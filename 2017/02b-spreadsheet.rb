puts ARGF.map { |line|
  list = line.chomp.split.map &:to_i
  line_result = nil
  0.upto(list.size - 2) do |i|
    (i+1).upto(list.size - 1) do |j|
      if list[i] % list[j] == 0
        line_result = list[i] / list[j]
      elsif list[j] % list[i] == 0
        line_result = list[j] / list[i]
      end
    end
  end

  line_result
}.inject :+
