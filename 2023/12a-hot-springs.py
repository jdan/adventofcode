import sys
import typing
import itertools

Arrangement = typing.List[typing.Literal["?", "#", "."]]

class Record:
    def __init__(self, pattern: Arrangement, groups: list[int]):
        self.pattern = pattern
        self.groups = groups

    def get_possible_arrangements(self):
        wildcard_indices = [idx for idx, cell in enumerate(self.pattern) if cell == "?"]
        num_wildcards = len(wildcard_indices)
        # for each wildcard, replace it with both a # and a .
        for replacements in itertools.product(["#", "."], repeat=num_wildcards):
            arrangement = self.pattern.copy()
            for i, replacement in enumerate(replacements):
                arrangement[wildcard_indices[i]] = typing.cast(typing.Literal["#", "."], replacement)
            yield arrangement

    def is_valid_arrangement(self, arrangement: Arrangement):
        # compute groups of "#"
        group_lengths = []
        current_group_length = 0
        for cell in arrangement:
            if cell == "#":
                current_group_length += 1
            else:
                if current_group_length > 0:
                    group_lengths.append(current_group_length)
                    current_group_length = 0
        if current_group_length > 0:
            group_lengths.append(current_group_length)

        # check if the groups match
        return group_lengths == self.groups

    def num_valid_arrangements(self):
        num_valid = 0
        for arrangement in self.get_possible_arrangements():
            if self.is_valid_arrangement(arrangement):
                num_valid += 1
        return num_valid

arrangement_sum = 0
for idx, line in enumerate(sys.stdin.readlines()):
    pattern, groups = line.strip().split(" ")
    record = Record(
        typing.cast(Arrangement, list(pattern)),
        list(map(int, groups.split(",")))
    )

    arrangement_sum += record.num_valid_arrangements()

print(arrangement_sum)
