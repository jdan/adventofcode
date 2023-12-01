import sys

sum = 0
for line in sys.stdin:
    nums = [int(n) for n in list(line) if n.isdigit()]
    sum += nums[0] * 10 + nums[-1]

print(sum)