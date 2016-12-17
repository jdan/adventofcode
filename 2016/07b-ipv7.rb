# http://adventofcode.com/2016/day/7

has_abba = ->(s) {
    # ABBA, B != A
    s =~ /(\w)(?!\1)(\w)\2\1/
}

def supernet(s)
    # Blast away all characters enclosed in brackets
    s.gsub(/\[(\w+)\]/, " ")
end

def hypernet(s)
    # Only return characters enclosed in brackets
    s.scan(/\[(\w+)\]/).flatten.join(" ")
end

def aba_sequences(s)
    # Lookahead but still match so we detect overlapping sequences
    #
    # Map with .join because scan will return an array of (matches)
    s.scan(/(\w)(?!\1)(?=(.)(\1))/).map &:join
end

def bab?(a, b)
    return b[0] == b[2] && b[0] == a[1] && a[0] == a[2] && a[0] == b[1]
end

total = 0

ARGF.each do |line|
    supernet_abas = aba_sequences(supernet(line))
    hypernet_abas = aba_sequences(hypernet(line))

    supports_ssl = supernet_abas.any? { |s_seq|
        hypernet_abas.any? { |h_seq|
            bab?(s_seq, h_seq)
        }
    }

    if supports_ssl
        total += 1
    end
end

puts total
