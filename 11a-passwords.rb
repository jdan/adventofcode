def valid_password?(password)
    /(.)\1.*(.)\2/ === password and
    /abc|bcd|cde|def|efg|fgh|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz/ === password
end

def next_password(password)
    (password.to_i(36) + 1).to_s(36).gsub("0", "a")
end

password = gets
    .chomp
    .gsub("i", "j")
    .gsub("o", "p")
    .gsub("l", "m")

while not valid_password?(password)
    password = next_password(password)
        .gsub("i", "j")
        .gsub("o", "p")
        .gsub("l", "m")
end

puts password
