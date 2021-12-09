import { strings } from "./util";

const heightMap = strings().map((line) =>
  line.split("").map((n) => parseInt(n))
);

function value(
  heightMap: number[][],
  row: number,
  col: number
) {
  if (heightMap[row] === undefined) {
    return Infinity;
  }

  if (heightMap[row][col] === undefined) {
    return Infinity;
  }

  return heightMap[row][col];
}

let totalRiskLevel = 0;
for (
  let row = 0;
  row < heightMap.length;
  row++
) {
  for (
    let col = 0;
    col < heightMap[row].length;
    col++
  ) {
    if (
      [
        value(heightMap, row + 1, col),
        value(heightMap, row - 1, col),
        value(heightMap, row, col + 1),
        value(heightMap, row, col - 1),
      ].every((v) => heightMap[row][col] < v)
    ) {
      totalRiskLevel +=
        heightMap[row][col] + 1;
    }
  }
}

console.log(totalRiskLevel);
