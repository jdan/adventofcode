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

def get_loop(start: typing.Tuple[int, int], grid: Grid) -> Loop:
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

loop = get_loop(starting, grid)
max_distance = max(loop.values())

# patch the original grid's start and end with an actual pipe
starting_x, starting_y = starting
above_in_loop = (starting_x, starting_y - 1) in loop and loop[(starting_x, starting_y - 1)] in [1, max_distance]
below_in_loop = (starting_x, starting_y + 1) in loop and loop[(starting_x, starting_y + 1)] in [1, max_distance]
left_in_loop = (starting_x - 1, starting_y) in loop and loop[(starting_x - 1, starting_y)] in [1, max_distance]
right_in_loop = (starting_x + 1, starting_y) in loop and loop[(starting_x + 1, starting_y)] in [1, max_distance]
if above_in_loop and below_in_loop:
    grid[starting] = '|'
elif left_in_loop and right_in_loop:
    grid[starting] = '-'
elif above_in_loop and right_in_loop:
    grid[starting] = 'L'
elif above_in_loop and left_in_loop:
    grid[starting] = 'J'
elif below_in_loop and right_in_loop:
    grid[starting] = 'F'
elif below_in_loop and left_in_loop:
    grid[starting] = '7'

max_x = max(loop.keys(), key=lambda x: x[0])[0]
max_y = max(loop.keys(), key=lambda x: x[1])[1]

# >>> print('\u250c')
# ┌
# >>> print('\u2510')
# ┐
# >>> print('\u2514')
# └
# >>> print('\u2518')
# ┘

fill: Grid = {}
for y in range(max_y + 1):
    is_outside = True
    for x in range(max_x + 1):
        fill[(x, y)] = 'O' if is_outside else 'I'

        # detect skips in the loop
        if (x, y) in loop and safe_get(grid, (x, y)) in '|7F':
            is_outside = not is_outside

def print_grid(grid: Grid, loop: Loop, max_x: int, max_y: int) -> None:
    for y in range(max_y + 1):
        for x in range(max_x + 1):
            if (x, y) in loop:
                # is a | piece
                if safe_get(grid, (x, y)) == '|':
                    print('\u2502', end='')
                # is a - piece
                elif safe_get(grid, (x, y)) == '-':
                    print('\u2500', end='')
                # is a 7 piece
                elif safe_get(grid, (x, y)) == '7':
                    # unicode bottom left
                    print('\u2510', end='')
                # is a L piece
                elif safe_get(grid, (x, y)) == 'L':
                    # unicode bottom right
                    print('\u2514', end='')
                # is a J piece
                elif safe_get(grid, (x, y)) == 'J':
                    # unicode top left
                    print('\u2518', end='')
                # is a F piece
                elif safe_get(grid, (x, y)) == 'F':
                    # unicode top right
                    print('\u250c', end='')
            elif (x, y) in fill:
                print(fill[(x, y)], end='')
            else:
                print(' ', end='')
        print()

print_grid(grid, loop, max_x, max_y)

num_enclosed = 0
for x, y in fill:
    if (x, y) in loop:
        continue
    elif fill[(x, y)] == 'I':
        num_enclosed += 1

print(num_enclosed)
