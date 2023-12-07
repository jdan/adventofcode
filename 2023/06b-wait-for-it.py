import sys
import re

# Time:      7  15   30
# Distance:  9  40  200

ws = re.compile(r"\s+")
lines = sys.stdin.readlines()

time = int("".join(ws.split(lines[0].strip())[1:]))
distance = int("".join(ws.split(lines[1].strip())[1:]))

means_to_win = 0

# optimize -> pointers from start and end?
for time_held in range(1, time):
    distance_traveled = time_held * (time - time_held)
    if distance_traveled > distance:
        means_to_win += 1

print(means_to_win)
