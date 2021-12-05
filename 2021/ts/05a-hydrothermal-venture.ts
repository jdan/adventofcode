import { strings } from "./util";

const grid: { [key: string]: number } = {};

strings().forEach((line) => {
  const [src, dest] = line.split(" -> ");
  const [[x1, y1], [x2, y2]] = [
    src,
    dest,
  ].map((p) =>
    p.split(",").map((s) => parseInt(s))
  );

  // Horizontal line
  if (y1 === y2) {
    const [a, b] = [
      Math.min(x1, x2),
      Math.max(x1, x2),
    ];

    for (let i = a; i <= b; i++) {
      grid[`${i},${y1}`] ||= 0;
      grid[`${i},${y1}`]++;
    }
  }

  // Vertical line
  if (x1 === x2) {
    const [a, b] = [
      Math.min(y1, y2),
      Math.max(y1, y2),
    ];

    for (let i = a; i <= b; i++) {
      grid[`${x1},${i}`] ||= 0;
      grid[`${x1},${i}`]++;
    }
  }
});

console.log(
  Object.values(grid).filter((p) => p >= 2)
    .length
);
