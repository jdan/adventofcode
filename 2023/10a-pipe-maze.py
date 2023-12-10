import sys
import typing

Grid = typing.Dict[typing.Tuple[int, int], str]

starting = (-1, -1)

grid: Grid = {}
for y, line in enumerate(sys.stdin):
    for x in range(len(line)):
        if line[x] == 'S':
            starting = (x, y)
        if line[x] in 'S|-LJ7F':
            grid[(x, y)] = line[x]

def safe_get(grid: Grid, pos: typing.Tuple[int, int]) -> str:
    if pos in grid:
        return grid[pos]
    return ' '

Loop = typing.Dict[typing.Tuple[int, int], int]

def loop_length(start: typing.Tuple[int, int], grid: Grid) -> Loop:
    loop: Loop = {}

    last_pos = None
    pos = start
    distance = 0
    while distance == 0 or pos != start:
        loop[pos] = distance
        distance += 1
        x, y = pos
        should_look_up = last_pos != (x, y-1) and safe_get(grid, pos) in 'S|LJ' and safe_get(grid, (x, y - 1)) in 'S|7F'
        should_look_down = last_pos != (x, y+1) and safe_get(grid, pos) in 'S|7F' and safe_get(grid, (x, y + 1)) in 'S|LJ'
        should_look_left = last_pos != (x-1, y) and safe_get(grid, pos) in 'S-J7' and safe_get(grid, (x - 1, y)) in 'S-LF'
        should_look_right = last_pos != (x+1, y) and safe_get(grid, pos) in 'S-LF' and safe_get(grid, (x + 1, y)) in 'S-J7'

        if should_look_up:
            last_pos = pos
            pos = (x, y - 1)
            continue
        elif should_look_down:
            last_pos = pos
            pos = (x, y + 1)
            continue
        elif should_look_left:
            last_pos = pos
            pos = (x - 1, y)
            continue
        elif should_look_right:
            last_pos = pos
            pos = (x + 1, y)
            continue

    return loop

# find the max distance in loop
max_distance = max(loop_length(starting, grid).values())
print((max_distance + 1) // 2)
