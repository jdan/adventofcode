import sys

def round_to_dict(round_str):
    round_dict = {}
    for item in round_str.split(", "):
        count, color = item.split()
        round_dict[color] = int(count)
    return round_dict

def is_valid_game(rounds):
    return all([is_valid_round(round_to_dict(round_str)) for round_str in rounds])

def is_valid_round(round_dict):
    # only 12 red cubes, 13 green cubes, and 14 blue cubes
    if "red" in round_dict and round_dict["red"] > 12:
        return False

    if "green" in round_dict and round_dict["green"] > 13:
        return False

    if "blue" in round_dict and round_dict["blue"] > 14:
        return False

    return True

valid_id_sum = 0

for line in sys.stdin:
    # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    game_str, rounds = line.split(": ")

    game_id = int(game_str.split()[1])
    rounds = rounds.split("; ")

    if is_valid_game(rounds):
        valid_id_sum += game_id

print(valid_id_sum)
