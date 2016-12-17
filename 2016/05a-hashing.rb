require "digest"

door_id = gets.chomp
i = 1
password = ""

8.times do
    until /^0{5}/ === Digest::MD5.hexdigest("#{door_id}#{i}")
        i += 1
    end

    password += Digest::MD5.hexdigest("#{door_id}#{i}")[5]
    puts "Found! #{password}"
    i += 1
end

puts password
