# http://adventofcode.com/2016/day/5

require "digest"

door_id = gets.chomp
i = 1
password = "________"
found = 0

until found == 8 do
    until /^0{5}/ === Digest::MD5.hexdigest("#{door_id}#{i}")
        i += 1
    end

    hash = Digest::MD5.hexdigest("#{door_id}#{i}")
    pos = hash[5]

    if /[0-7]/ === pos && password[pos.to_i] == "_"
        password[pos.to_i] = hash[6]
        found += 1
        puts "Accepted #{pos}"
        puts password
    else
        puts "Rejecting #{pos}"
    end

    i += 1
end

puts password
