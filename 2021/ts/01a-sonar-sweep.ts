import { numbers } from "./util";

const depths = numbers();
let increases = 0;
for (let i = 1; i < depths.length; i++) {
  if (depths[i] > depths[i - 1]) {
    increases++;
  }
}

console.log(increases);
