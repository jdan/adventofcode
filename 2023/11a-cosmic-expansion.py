import sys
import typing

galaxy_lines = sys.stdin.readlines()

# Pre-process the galaxy to take "expansion" into account

width = len(galaxy_lines[0].strip())
height = len(galaxy_lines)

# empty rows consist of only repeated "." characters
empty_row_idxs = [idx for idx, line in enumerate(galaxy_lines) if line.strip() == "." * len(line.strip())]

for idx, empty_row in enumerate(empty_row_idxs):
    # insert an empty line before each empty row
    galaxy_lines.insert(empty_row + idx, "." * width + "\n")

empty_column_idxs = [idx for idx in range(width) if all(line[idx] == "." for line in galaxy_lines)]

for idx, empty_column in enumerate(empty_column_idxs):
    # insert a "." character at each empty column
    for line_idx, line in enumerate(galaxy_lines):
        galaxy_lines[line_idx] = line[:empty_column + idx] + "." + line[empty_column + idx:]

class Point(typing.TypedDict):
    x: int
    y: int

galaxies: typing.List[Point] = []
for y, line in enumerate(galaxy_lines):
    for x, char in enumerate(line.strip()):
        if char == "#":
            galaxies.append({"x": x, "y": y})

print(galaxies)

sum_of_distances = 0
for a in range(len(galaxies) - 1):
    for b in range(a, len(galaxies)):
        dist = abs(galaxies[a]["x"] - galaxies[b]["x"]) + abs(galaxies[a]["y"] - galaxies[b]["y"])
        sum_of_distances += dist

print(sum_of_distances)
