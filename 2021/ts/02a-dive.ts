import { strings } from "./util";

let x = 0;
let y = 0;

strings().forEach((line) => {
  const [dir, _dist] = line.split(" ");
  const dist = parseInt(_dist);
  if (dir === "forward") {
    x += dist;
  } else if (dir === "up") {
    y -= dist;
  } else if (dir === "down") {
    y += dist;
  } else {
    throw "Unrecognized dir -- " + dir;
  }
});

console.log(x * y);
