# http://adventofcode.com/day/4

require "digest"

prefix = gets.chomp
i = 0

loop do
    md5 = Digest::MD5.hexdigest(prefix + i.to_s)
    # 6 zeros instead of 5
    break if md5 =~ /^0{6}/
    i += 1
end

puts i
