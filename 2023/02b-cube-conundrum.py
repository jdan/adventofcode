import sys

def round_to_dict(round_str):
    round_dict = {}
    for item in round_str.split(", "):
        count, color = item.split()
        round_dict[color] = int(count)
    return round_dict

def cube_power(rounds):
    min_red = 0
    min_green = 0
    min_blue = 0

    for round_str in rounds:
        round_dict = round_to_dict(round_str)

        if "red" in round_dict:
            min_red = max(min_red, round_dict["red"])

        if "green" in round_dict:
            min_green = max(min_green, round_dict["green"])

        if "blue" in round_dict:
            min_blue = max(min_blue, round_dict["blue"])

    return min_red * min_green * min_blue

power_sum = 0

for line in sys.stdin:
    # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    game_str, rounds = line.split(": ")
    rounds = rounds.split("; ")

    power_sum += cube_power(rounds)

print(power_sum)
