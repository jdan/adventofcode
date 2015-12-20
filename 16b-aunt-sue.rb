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

def extract_field(string, field)
    re = Regexp.new("#{field}: (\\d+)")
    result = string.match(re)

    result[1].to_i unless result.nil?
end

ARGF.each do |line|
    sue_n = line.match(/Sue (\d+)/)[1].to_i

    is_a_match = result.keys.map { |key|
        known_data = extract_field(line, key)

        if known_data.nil?
            true

        # the cats and trees readings indicates that there are greater
        # than that many
        elsif key == :cats or key == :trees
            known_data > result[key]

        # while the pomeranians and goldfish readings indicate that there
        # are fewer than that many
        elsif key == :pomeranians or key == :goldfish
            known_data < result[key]

        else
            known_data == result[key]
        end
    }.all?

    if is_a_match
        puts sue_n
        break
    end
end
