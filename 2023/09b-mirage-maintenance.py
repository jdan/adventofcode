import sys
import typing

class Sequence:
    def __init__(self, seq):
        self.seq = seq

    def predict_next(self):
        stack = [self.seq]
        while not all(map(lambda n: n == 0, stack[-1])):
            peek = stack[-1]
            deltas = [peek[i + 1] - peek[i] for i in range(0, len(peek) - 1)]
            stack.append(deltas)

        # at this point len(stack) should be able to tell us if the sequence is
        # linear, quadratic, etc.
        # [[0, 3, 6, 9, 12, 15], [3, 3, 3, 3, 3], [0, 0, 0, 0]]

        while len(stack) > 1:
            # grab the delta at the start of the list
            delta = stack.pop()[0]
            peek = stack[-1]
            # peek[0] - new_item = delta
            # peek[0] = delta + new_item
            # new_item = peek[0] - delta
            peek.insert(0, peek[0] - delta)

        # return the first item of the remaining item in the stack
        return stack[-1][0]

total_sum = 0
for line in sys.stdin:
    seq = Sequence([int(x) for x in line.split()])
    total_sum += seq.predict_next()

print(total_sum)
