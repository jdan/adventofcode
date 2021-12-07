import { numberLine } from "./util";

const positions = numberLine();

console.log(
  Math.min(
    ...positions.map((_, target) =>
      positions.reduce((total, pos) => {
        const stepsRequired = Math.abs(
          pos - target
        );
        const fuelRequired =
          (stepsRequired *
            (stepsRequired + 1)) /
          2;
        return total + fuelRequired;
      }, 0)
    )
  )
);
