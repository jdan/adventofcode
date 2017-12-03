ingredients = []

ARGF.each do |line|
    ingredients << line.scan(/-?\d+/).map(&:to_i)
end

def compute_score(ingredients, capacity_left, amounts_so_far)
    if ingredients.size == 1

    else

end

print ingredients
puts
