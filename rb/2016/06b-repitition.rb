# http://adventofcode.com/2016/day/6

messages = ARGF.to_a

puts 0.upto(messages.first.chomp.length - 1)    # for each char index `n`
    .to_a
    .map { |i|
        messages
            .map { |message| message[i] }       # get the `n`th characters
            .group_by { |a| a }                 # group by letter
            .to_a
            .sort_by { |pair| pair[1].count }   # sort by frequency
            .first                              # extract the least frequent
            .first                              # extract the character
    }
    .join("")                                   # join 'em back
