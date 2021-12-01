import { numbers, sum } from "./util";

const depths = numbers();
let increases = 0;
for (let i = 3; i < depths.length; i++) {
  const prev = sum(depths.slice(i - 3, i));
  const curr = sum(
    depths.slice(i - 2, i + 1)
  );
  if (curr > prev) {
    increases++;
  }
}

console.log(increases);
