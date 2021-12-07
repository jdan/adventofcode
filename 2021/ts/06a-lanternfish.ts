import { stdin } from "./util";

function tick(arr: number[]) {
  const len = arr.length;
  for (let i = 0; i < len; i++) {
    arr[i] -= 1;
    if (arr[i] < 0) {
      arr.push(8);
      arr[i] = 6;
    }
  }
}

const lanternfish = stdin()
  .split(",")
  .map((n) => parseInt(n));
for (let i = 0; i < 80; i++) {
  tick(lanternfish);
}
console.log(lanternfish.length);
