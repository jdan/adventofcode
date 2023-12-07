import sys
import re

# Time:      7  15   30
# Distance:  9  40  200

ws = re.compile(r"\s+")
lines = sys.stdin.readlines()

times = [int(t) for t in ws.split(lines[0].strip())[1:]]
distances = [int(d) for d in ws.split(lines[1].strip())[1:]]

result = 1
for idx in range(len(times)):
    time = times[idx]
    distance = distances[idx]

    means_to_win = 0
    for time_held in range(1, time):
        distance_traveled = time_held * (time - time_held)
        if distance_traveled > distance:
            means_to_win += 1

    result *= means_to_win

print(result)
