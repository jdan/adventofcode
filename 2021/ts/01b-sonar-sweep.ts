import { numbers } from "./util";

const depths = numbers();
let increases = 0;
for (let i = 3; i < depths.length; i++) {
  if (depths[i] > depths[i - 3]) {
    increases++;
  }
}

console.log(increases);
