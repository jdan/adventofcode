import {
  equals,
  permutations,
  strings,
} from "./util";

/**
 *    aaaa
 *   b    c
 *   b    c
 *    dddd
 *   e    f
 *   e    f
 *    gggg
 */

const candidates = permutations(
  "abcdefg".split("")
).map((list) => {
  const map: { [key: string]: number } = {};
  list.forEach((value, idx) => {
    map[value] = idx;
  });
  return map;
});

const zero = new Set([0, 1, 2, 4, 5, 6]);
const one = new Set([2, 5]);
const two = new Set([0, 2, 3, 4, 6]);
const three = new Set([0, 2, 3, 5, 6]);
const four = new Set([1, 2, 3, 5]);
const five = new Set([0, 1, 3, 5, 6]);
const six = new Set([0, 1, 3, 4, 5, 6]);
const seven = new Set([0, 2, 5]);
const eight = new Set([0, 1, 2, 3, 4, 5, 6]);
const nine = new Set([0, 1, 2, 3, 5, 6]);

function panelsToDigit(panels: Set<number>) {
  return [
    zero,
    one,
    two,
    three,
    four,
    five,
    six,
    seven,
    eight,
    nine,
  ].findIndex((digit) =>
    equals(digit, panels)
  );
}

function wordToDigit(
  word: string,
  derangement: { [key: string]: number }
) {
  const panels = new Set(
    word.split("").map((c) => derangement[c])
  );
  return panelsToDigit(panels);
}

let result = 0;
strings().forEach((line) => {
  const [measured, output] = line
    .split(" | ")
    .map((half) => half.split(" "));

  for (
    let i = 0;
    i < candidates.length;
    i++
  ) {
    let invalid = false;
    for (
      let j = 0;
      j < measured.length;
      j++
    ) {
      if (
        wordToDigit(
          measured[j],
          candidates[i]
        ) < 0
      ) {
        invalid = true;
      }
    }

    if (!invalid) {
      const digits = output.map((word) =>
        wordToDigit(word, candidates[i])
      );
      result += parseInt(digits.join(""));
    }
  }
});

console.log(result);
