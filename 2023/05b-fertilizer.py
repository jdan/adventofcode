import sys
from typing import TypedDict

class MappedRange(TypedDict):
    source_start: int
    source_end: int
    destination_start: int
    destination_end: int
Mapping = list[MappedRange]

class Range(TypedDict):
    start: int
    end: int

def map_range(mapping: Mapping, source: Range) -> list[Range]:
    """
    Map a range from source to destination
    """
    output_ranges: list[Range] = []
    mapped_ranges: list[Range] = []

    for mapped_range in mapping:
        if source["end"] >= mapped_range["source_start"] and source["start"] <= mapped_range["source_end"]:
            # find the intersection of the two ranges
            intersection_start = max(source["start"], mapped_range["source_start"])
            intersection_end = min(source["end"], mapped_range["source_end"])

            mapped_ranges.append({
                "start": intersection_start,
                "end": intersection_end
            })

            # map the intersection
            intersection: Range = {
                "start": mapped_range["destination_start"] + (intersection_start - mapped_range["source_start"]),
                "end": mapped_range["destination_start"] + (intersection_end - mapped_range["source_start"])
            }
            output_ranges.append(intersection)

    # which part of the source range was not mapped?
    # this is soooo confusing
    mapped_ranges.sort(key=lambda r: r["start"])
    cursor = source["start"]
    for mapped_range in mapped_ranges:
        if cursor < mapped_range["start"]:
            output_ranges.append({
                "start": cursor,
                "end": mapped_range["start"] - 1
            })
        cursor = mapped_range["end"] + 1

    if cursor <= source["end"]:
        output_ranges.append({
            "start": cursor,
            "end": source["end"]
        })

    return output_ranges

sections = sys.stdin.read().split("\n\n")
_, seeds_str = sections[0].split(": ")
seed_input = [int(n) for n in seeds_str.split(" ")]

seed_ranges: list[Range] = []
for i in range(0, len(seed_input), 2):
    seed_ranges.append({
        "start": seed_input[i],
        "end": seed_input[i] + seed_input[i + 1] - 1
    })

mappings: list[Mapping] = []
for section in sections[1:]:
    lines = section.split("\n")

    ranges: list[MappedRange] = []
    for line in lines[1:]:
        destination_start, source_start, length = map(int, line.split(" "))
        ranges.append({
            "source_start": source_start,
            "source_end": source_start + length - 1,
            "destination_start": destination_start,
            "destination_end": destination_start + length - 1
        })

    mappings.append(ranges)

def soil_locations(mappings: list[Mapping], seed_ranges: list[Range]):
    # print(seed_ranges)

    if len(mappings) == 0:
        return seed_ranges

    new_ranges = []
    for seed_range in seed_ranges:
        mapped_ranges = map_range(mappings[0], seed_range)
        new_ranges.extend(mapped_ranges)

    return soil_locations(mappings[1:], new_ranges)

print(min([loc["start"] for loc in soil_locations(mappings, seed_ranges)]))
