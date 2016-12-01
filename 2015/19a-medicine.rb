# http://adventofcode.com/day/19

def index_all(haystack, needle)
    offset = 0
    indices = []

    # Initial value
    index = haystack.index(needle, offset)
    until index.nil?
        indices << index

        # Move the offset
        offset = index + 1

        # Find the next index
        index = haystack.index(needle, offset)
    end

    indices
end

substitutions = {}
original = ""
molecules = []

ARGF.each do |line|
    if line =~ /=>/
        find, replace = line.scan(/(\w+) => (\w+)/)[0]

        if substitutions[find]
            substitutions[find] << replace
        else
            substitutions[find] = [replace]
        end
    elsif line =~ /\w+/
        original = line
    end
end

# For each substitution rule
substitutions.each do |key, value|
    # For each index of the substitution in the string
    index_all(original, key).each do |index|
        # For each replacement
        value.each do |replacement|
            # Build a new molecule
            molecules << original[0...index] +
                         original[index..-1].sub(key, replacement)
        end
    end
end

puts molecules.uniq.count
