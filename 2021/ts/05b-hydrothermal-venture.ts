import { strings } from "./util";

const grid: { [key: string]: number } = {};

// Iterate from a to b in either direction
function* range(a: number, b: number) {
  if (a < b) {
    for (let i = a; i <= b; i++) {
      yield i;
    }
  } else {
    for (let i = a; i >= b; i--) {
      yield i;
    }
  }
}

function* lineSegment(
  x1: number,
  y1: number,
  x2: number,
  y2: number
) {
  if (y1 === y2) {
    // Horizontal line
    for (let x of range(x1, x2)) {
      yield [x, y1];
    }
  } else if (x1 === x2) {
    // Vertical line
    for (let y of range(y1, y2)) {
      yield [x1, y];
    }
  } else {
    // Diagonal line
    let xs = Array.from(range(x1, x2));
    let ys = Array.from(range(y1, y2));

    yield* xs.map((_, idx) => [
      xs[idx],
      ys[idx],
    ]);
  }
}

strings().forEach((line) => {
  const [src, dest] = line.split(" -> ");
  const [[x1, y1], [x2, y2]] = [
    src,
    dest,
  ].map((p) =>
    p.split(",").map((s) => parseInt(s))
  );

  for (let [x, y] of lineSegment(
    x1,
    y1,
    x2,
    y2
  )) {
    grid[`${x},${y}`] ||= 0;
    grid[`${x},${y}`]++;
  }
});

console.log(
  Object.values(grid).filter((p) => p >= 2)
    .length
);
