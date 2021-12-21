import { paragraphs } from "./util"

const [coords, folds] = paragraphs()

const firstFold = folds
  .split("\n")[0]
  .match(/fold along (x|y)=(\d+)/)

const points = new Set()

coords.split("\n").forEach(line => {
  let [x, y] = line
    .split(",")
    .map(n => parseInt(n))

  if (firstFold[1] === "x") {
    const horizontalFold = parseInt(
      firstFold[2]
    )
    if (x > horizontalFold) {
      x =
        horizontalFold - (x - horizontalFold)
    }
  } else {
    const verticalFold = parseInt(
      firstFold[2]
    )
    if (y > verticalFold) {
      y = verticalFold - (y - verticalFold)
    }
  }

  points.add(`${x},${y}`)
})

console.log(points.size)
