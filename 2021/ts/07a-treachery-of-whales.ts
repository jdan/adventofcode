import { numberLine } from "./util";

const positions = numberLine();

console.log(
  Math.min(
    ...positions.map((_, target) =>
      positions.reduce(
        (total, pos) =>
          total + Math.abs(pos - target),
        0
      )
    )
  )
);
