import sys

def extract_numbers(line):
    s = ''
    while len(line) > 0:
        if line.startswith('one'):
            s += '1'
            line = line[1:]
        elif line.startswith('two'):
            s += '2'
            line = line[1:]
        elif line.startswith('three'):
            s += '3'
            line = line[1:]
        elif line.startswith('four'):
            s += '4'
            line = line[1:]
        elif line.startswith('five'):
            s += '5'
            line = line[1:]
        elif line.startswith('six'):
            s += '6'
            line = line[1:]
        elif line.startswith('seven'):
            s += '7'
            line = line[1:]
        elif line.startswith('eight'):
            s += '8'
            line = line[1:]
        elif line.startswith('nine'):
            s += '9'
            line = line[1:]
        elif line[0].isdigit():
            s += line[0]
            line = line[1:]
        else:
            line = line[1:]
    
    return s

sum = 0
for line in sys.stdin:
    line = extract_numbers(line)

    nums = [int(n) for n in list(line) if n.isdigit()]
    sum += nums[0] * 10 + nums[-1]

print(sum)