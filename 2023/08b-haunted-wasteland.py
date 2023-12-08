import sys
import typing

dirs, node_defs = sys.stdin.read().split('\n\n')

graph: dict[str, tuple[str, str]] = {}
for line in node_defs.split("\n"):
    name, lr = line.split(' = ')
    left, right = lr[1:-1].split(', ')

    graph[name] = (left, right)

starting_nodes = list(filter(lambda node: node[-1] == "A", graph.keys()))
required_steps = []

for node in starting_nodes:
    steps = 0
    while node[-1] != "Z":
        dir = dirs[steps % len(dirs)]
        paths = graph[node]

        if dir == 'L':
            node = paths[0]
        elif dir == 'R':
            node = paths[1]

        steps += 1
    required_steps.append(steps)

# print the lcm of all the required steps
from math import lcm
print(lcm(*required_steps))
