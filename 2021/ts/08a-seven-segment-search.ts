import { strings } from "./util";

let result = 0;
strings().forEach((line) => {
  const output = line
    .split(" | ")[1]
    .split(" ");
  result += output.filter((word) =>
    new Set([2, 3, 4, 7]).has(word.length)
  ).length;
});
console.log(result);
