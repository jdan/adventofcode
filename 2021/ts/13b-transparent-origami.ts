import { paragraphs } from "./util"

const [coords, folds] = paragraphs()
let points: Set<string> = new Set()

coords.split("\n").forEach(line => {
  const [x, y] = line
    .split(",")
    .map(n => parseInt(n))

  points.add(`${x},${y}`)
})

const instructions = folds
  .split("\n")
  .map(line =>
    line.match(/fold along (x|y)=(\d+)/)
  )
instructions.forEach(
  ([_, axis, valueStr]) => {
    const value = parseInt(valueStr)

    points = new Set(
      [...points].map(coord => {
        let [x, y] = coord
          .split(",")
          .map(n => parseInt(n))

        if (axis === "x" && x > value) {
          x = value - (x - value)
        } else if (
          axis === "y" &&
          y > value
        ) {
          y = value - (y - value)
        }

        return `${x},${y}`
      })
    )
  }
)

const coordinates = [...points].map(point =>
  point.split(",").map(n => parseInt(n))
)
const width = Math.max(
  ...coordinates.map(c => c[0])
)
const height = Math.max(
  ...coordinates.map(c => c[1])
)
const grid = Array.from({
  length: height + 1,
}).map(_ =>
  Array.from({ length: width + 1 }, _ => " ")
)

coordinates.forEach(([x, y]) => {
  grid[y][x] = "#"
})

console.log(
  grid.map(line => line.join("")).join("\n")
)
