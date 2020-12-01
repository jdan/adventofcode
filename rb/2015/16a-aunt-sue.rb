# http://adventofcode.com/day/16

result = {
    children: 3,
    cats: 7,
    samoyeds: 2,
    pomeranians: 3,
    akitas: 0,
    vizslas: 0,
    goldfish: 5,
    trees: 3,
    cars: 2,
    perfumes: 1
}

def match(string, field)
    re = Regexp.new("#{field}: (\\d+)")
    result = string.match(re)

    result[1].to_i unless result.nil?
end

ARGF.each do |line|
    sue_n = line.match(/Sue (\d+)/)[1].to_i

    is_a_match = result.keys.map { |key|
        known_data = match(line, key)
        true if known_data.nil? or known_data == result[key]
    }.all?

    if is_a_match
        puts sue_n
        break
    end
end
