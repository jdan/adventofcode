import { strings } from "./util";

const slots: number[][] = [];
strings().forEach((bs) => {
  bs.split("").forEach((bit, idx) => {
    slots[idx] ||= [0, 0];
    slots[idx][parseInt(bit)]++;
  });
});

const gamma = parseInt(
  slots
    .map(([zeroes, ones]) =>
      zeroes > ones ? "0" : "1"
    )
    .join(""),
  2
);

const epsilon = parseInt(
  slots
    .map(([zeroes, ones]) =>
      zeroes > ones ? "1" : "0"
    )
    .join(""),
  2
);

console.log(gamma * epsilon);
