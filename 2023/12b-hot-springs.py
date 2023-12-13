import sys
import typing
import itertools

Arrangement = typing.List[typing.Literal["?", "#", "."]]

class Record:
    def __init__(self, pattern: Arrangement, groups: list[int]):
        self.pattern = pattern
        self.groups = groups
        self.n = 0

    def num_possible_arrangements(self):
        wildcard_indices = [idx for idx, cell in enumerate(self.pattern) if cell == "?"]
        num_wildcards = len(wildcard_indices)

        def inner(replacements) -> int:
            arrangement = self.pattern.copy()
            for i, replacement in enumerate(replacements):
                arrangement[wildcard_indices[i]] = typing.cast(typing.Literal["#", "."], replacement)

            if len(replacements) == num_wildcards:
                if self.is_valid(arrangement):
                    self.n += 1
                    if self.n % 1000 == 0:
                        print(self.n)
                    return 1
                else:
                    return 0

            if self.is_valid_so_far(arrangement):
                return inner(replacements + ["#"]) + inner(replacements + ["."])
            else:
                return 0

        return inner([])

    def is_valid(self, arrangement: Arrangement):
        """
        Checks if a finished arrangement is valid
        """
        # count the runs of #
        groups = []
        current_group = 0
        for cell in arrangement:
            if cell == "#":
                current_group += 1
            else:
                if current_group > 0:
                    groups.append(current_group)
                    current_group = 0
        if current_group > 0:
            groups.append(current_group)

        return groups == self.groups

    def is_valid_so_far(self, arrangement: Arrangement):
        """
        Checks if an in-progress arrangement is valid.
        If not, we'll prune the branch.
        """
        # count the runs of #
        # until we reach the first ?
        groups = []
        current_group = 0
        for cell in arrangement:
            if cell == "#":
                current_group += 1
            elif cell == "?":
                break
            else:
                if current_group > 0:
                    groups.append(current_group)
                    current_group = 0
        if current_group > 0:
            groups.append(current_group)

        # Optimization, we're out of room!
        # how many characters appear "?" onward?
        # if it's more than the number of groups we have left, we're out of room
        chars_remaining = len(arrangement) - arrangement.index("?")
        groups_left = len(self.groups) - len(groups)
        # might be able to divide by 2, tbd
        if groups_left > chars_remaining // 2:
            return False

        for i in range(len(groups)):
            if i >= len(self.groups):
                return False

            # The last group can be less
            if i == len(groups) - 1:
                if groups[i] > self.groups[i]:
                    return False
            elif groups[i] != self.groups[i]:
                return False

        return True

arrangement_sum = 0
for idx, line in enumerate(sys.stdin.readlines()):
    pattern, groups = line.strip().split(" ")
    groups = list(map(int, groups.split(",")))

    repeated_pattern = "?".join([pattern] * 5)
    repeated_groups = groups * 5

    print(repeated_pattern, repeated_groups)

    record = Record(
        typing.cast(Arrangement, list(repeated_pattern)),
        repeated_groups
    )

    arrangement_sum += record.num_possible_arrangements()

print(arrangement_sum)
