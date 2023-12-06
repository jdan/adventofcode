import sys
from typing import TypedDict

class Range(TypedDict):
    destination_start: int
    source_start: int
    length: int
Mapping = list[Range]

sections = sys.stdin.read().split("\n\n")
_, seeds_str = sections[0].split(": ")
seeds = [int(n) for n in seeds_str.split(" ")]

def map_get(mapping: Mapping, source: int) -> int:
    for range in mapping:
        if source >= range["source_start"] and source < range["source_start"] + range["length"]:
            return range["destination_start"] + (source - range["source_start"])
    return source

mappings: list[Mapping] = []
for section in sections[1:]:
    lines = section.split("\n")

    ranges: list[Range] = []
    for line in lines[1:]:
        destination_start, source_start, length = map(int, line.split(" "))
        ranges.append({
            "destination_start": destination_start,
            "source_start": source_start,
            "length": length
        })

    mappings.append(ranges)

def soil_location(seed: int):
    for mapping in mappings:
        seed = map_get(mapping, seed)
    return seed

print(min([soil_location(seed) for seed in seeds]))
