import sys
import typing

dirs, node_defs = sys.stdin.read().split('\n\n')

graph: dict[str, tuple[str, str]] = {}
for line in node_defs.split("\n"):
    name, lr = line.split(' = ')
    left, right = lr[1:-1].split(', ')

    graph[name] = (left, right)

curr = 'AAA'
steps = 0
while curr != 'ZZZ':
    dir = dirs[steps % len(dirs)]
    paths = graph[curr]

    if dir == 'L':
        curr = paths[0]
    elif dir == 'R':
        curr = paths[1]

    steps += 1

print(steps)
