import re
import sys
from typing import TypedDict

# 467..114..
# ...*......
# ..35..633.
# ......#...
# 617*......
# .....+.58.
# ..592.....
# ......755.
# ...$.*....
# .664.598..

class Part(TypedDict):
    part_number: int
    row: int
    start: int
    end: int

class Symbol(TypedDict):
    char: str
    row: int
    column: int

parts: list[Part] = []
symbols: list[Symbol] = []

for row, line in enumerate(sys.stdin):
    # parse parts and symbols out of the line
    # and add them to parts and symbols

    # First pass, extract all numbers
    # and gather the start and end
    matches = re.finditer(r"\d+", line)
    for match in matches:
        start = match.start()
        end = match.end()
        part_number = int(match.group())

        parts.append({
            "part_number": part_number,
            "row": row,
            "start": start,
            "end": end
        })
    # Second pass, extract all symbols
    # which are defined as anything that
    # is not a number or period or newline
    matches = re.finditer(r"[^\d\n.]", line)
    for match in matches:
        column = match.start()
        char = match.group()

        symbols.append({
            "char": char,
            "row": row,
            "column": column
        })

part_id_sum = 0
for part in parts:
    # loop through all symbols and check if any are adjacent to this part
    is_adjacent = False
    for symbol in symbols:
        # check if the symbol is on the same row as the part
        if symbol["row"] == part["row"]:
            # check if the symbol is adjacent to the part
            if symbol["column"] == part["start"] - 1 or symbol["column"] == part["end"]:
                is_adjacent = True
                break

        # check if the symbol is on the row above or below the part
        if symbol["row"] == part["row"] - 1 or symbol["row"] == part["row"] + 1:
            # check if the symbol is adjacent to the part
            # annoying off-by-one error because "abc" -> start = 0, end = 3
            if symbol["column"] >= part["start"] - 1 and symbol["column"] <= part["end"]:
                is_adjacent = True
                break

    if is_adjacent:
        part_id_sum += part["part_number"]

print(part_id_sum)
