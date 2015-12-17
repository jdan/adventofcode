require "digest"

prefix = gets.chomp
i = 0

loop do
    md5 = Digest::MD5.hexdigest(prefix + i.to_s)
    break if md5 =~ /^0{5}/
    i += 1
end

puts i
