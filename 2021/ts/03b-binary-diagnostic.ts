import { strings } from "./util";

const input = strings();

function oxygenGeneratorRating(
  nums: string[],
  idx: number
): number {
  if (nums.length === 1) {
    return parseInt(nums[0], 2);
  }

  const [zeroes, ones] = nums.reduce(
    ([zeroes, ones], num) =>
      num[idx] === "0"
        ? [zeroes + 1, ones]
        : [zeroes, ones + 1],
    [0, 0]
  );

  if (zeroes > ones) {
    return oxygenGeneratorRating(
      nums.filter((num) => num[idx] === "0"),
      idx + 1
    );
  } else {
    return oxygenGeneratorRating(
      nums.filter((num) => num[idx] === "1"),
      idx + 1
    );
  }
}

function co2ScrubberRating(
  nums: string[],
  idx: number
): number {
  if (nums.length === 1) {
    return parseInt(nums[0], 2);
  }

  const [zeroes, ones] = nums.reduce(
    ([zeroes, ones], num) =>
      num[idx] === "0"
        ? [zeroes + 1, ones]
        : [zeroes, ones + 1],
    [0, 0]
  );

  if (zeroes > ones) {
    return co2ScrubberRating(
      nums.filter((num) => num[idx] === "1"),
      idx + 1
    );
  } else {
    return co2ScrubberRating(
      nums.filter((num) => num[idx] === "0"),
      idx + 1
    );
  }
}

console.log(
  oxygenGeneratorRating(input, 0) *
    co2ScrubberRating(input, 0)
);
