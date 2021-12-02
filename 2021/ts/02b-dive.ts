import { strings } from "./util";

let x = 0;
let y = 0;
let aim = 0;

strings().forEach((line) => {
  const [dir, _dist] = line.split(" ");
  const dist = parseInt(_dist);
  if (dir === "forward") {
    x += dist;
    y += aim * dist;
  } else if (dir === "up") {
    aim -= dist;
  } else if (dir === "down") {
    aim += dist;
  } else {
    throw "Unrecognized dir -- " + dir;
  }
});

console.log(x * y);
