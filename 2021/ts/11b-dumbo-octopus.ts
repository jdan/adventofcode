import { strings } from "./util"

const octopuses: number[][] = []
strings().forEach(line => {
  octopuses.push(
    line.split("").map(c => parseInt(c))
  )
})

function increaseNeighbor(
  r: number,
  c: number,
  toFlash: [number, number][]
) {
  if (
    r >= 0 &&
    r < octopuses.length &&
    c >= 0 &&
    c < octopuses[r].length &&
    octopuses[r][c] < 10
  ) {
    octopuses[r][c]++
    if (octopuses[r][c] === 10) {
      toFlash.push([r, c])
    }
  }
}

function tickOnce() {
  let flashes = 0
  const toFlash: [number, number][] = []
  octopuses.forEach((row, r) =>
    row.forEach((_, c) => {
      octopuses[r][c]++
      if (octopuses[r][c] === 10) {
        toFlash.push([r, c])
      }
    })
  )

  while (toFlash.length > 0) {
    const [r, c] = toFlash.pop()
    if (octopuses[r][c] === 10) {
      flashes++
      ;[
        [r - 1, c - 1],
        [r - 1, c],
        [r - 1, c + 1],
        [r, c - 1],
        [r, c + 1],
        [r + 1, c - 1],
        [r + 1, c],
        [r + 1, c + 1],
      ].forEach(([r, c]) => {
        increaseNeighbor(r, c, toFlash)
      })
    }
  }

  octopuses.forEach((row, r) =>
    row.forEach((_, c) => {
      if (octopuses[r][c] === 10) {
        octopuses[r][c] = 0
      }
    })
  )

  return flashes
}

const totalOctopuses =
  octopuses.length * octopuses[0].length

for (let step = 1; true; step++) {
  const flashes = tickOnce()
  if (flashes === totalOctopuses) {
    console.log(step)
    break
  }
}
