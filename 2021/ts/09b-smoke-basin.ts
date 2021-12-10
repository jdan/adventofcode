import { strings } from "./util";

const heightMap = strings().map((line) =>
  line.split("").map((n) => parseInt(n))
);

const basinMap = heightMap.map((row) =>
  row.map((_) => 0)
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

function flood(
  row: number,
  col: number,
  id: number
) {
  [
    [row + 1, col],
    [row - 1, col],
    [row, col + 1],
    [row, col - 1],
  ].forEach(([neighborRow, neighborCol]) => {
    if (
      value(
        basinMap,
        neighborRow,
        neighborCol
      ) !== 0
    ) {
      return;
    }

    const neighborValue = value(
      heightMap,
      neighborRow,
      neighborCol
    );
    if (
      neighborValue < 9 &&
      neighborValue !== heightMap[row][col]
    ) {
      basinMap[neighborRow][neighborCol] =
        id;
      flood(neighborRow, neighborCol, id);
    }
  });
}

let currentBasinId = 1;
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
    const height = heightMap[row][col];
    if (
      height !== 9 &&
      !basinMap[row][col]
    ) {
      basinMap[row][col] = currentBasinId;
      flood(row, col, currentBasinId);
      currentBasinId++;
    }
  }
}

const basinSizes: { [key: number]: number } =
  {};
basinMap.forEach((row) =>
  row.forEach((basinId) => {
    if (basinId === 0) return;
    basinSizes[basinId] ||= 0;
    basinSizes[basinId]++;
  })
);

console.log(
  Object.values(basinSizes)
    .sort((a, b) => b - a)
    .slice(0, 3)
    .reduce((a, b) => a * b, 1)
);
