import { stdin } from "./util";

const lanternfish = [
  0, 0, 0, 0, 0, 0, 0, 0, 0,
];
stdin()
  .split(",")
  .map((n) => lanternfish[parseInt(n)]++);

for (let i = 0; i < 256; i++) {
  const prev = lanternfish.slice();

  for (let j = 0; j < 8; j++) {
    lanternfish[j] = prev[j + 1];
  }

  // In addition to the 7s turning into 6s, 0s spawn a 6
  lanternfish[6] += prev[0];

  // Each 0 spawns an 8
  lanternfish[8] = prev[0];
}

// Total
console.log(
  lanternfish.reduce((a, b) => a + b, 0)
);
