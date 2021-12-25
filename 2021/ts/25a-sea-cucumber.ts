import { strings } from "./util"

let cucumbers = strings().map(line =>
  line.split("")
)
for (let step = 1; true; step++) {
  const nextCucumbers = cucumbers.map(line =>
    line.slice()
  )

  for (
    let i = 0;
    i < cucumbers.length;
    i++
  ) {
    for (
      let j = 0;
      j < cucumbers[i].length;
      j++
    ) {
      let jNext =
        (j + 1) % cucumbers[i].length

      if (
        cucumbers[i][j] === ">" &&
        cucumbers[i][jNext] === "."
      ) {
        nextCucumbers[i][j] = "."
        nextCucumbers[i][jNext] = ">"
      }
    }
  }

  const cucumbersAfterEast =
    nextCucumbers.map(line => line.slice())

  for (
    let i = 0;
    i < cucumbersAfterEast.length;
    i++
  ) {
    for (
      let j = 0;
      j < cucumbersAfterEast[i].length;
      j++
    ) {
      let iNext =
        (i + 1) % cucumbersAfterEast.length

      if (
        cucumbersAfterEast[i][j] === "v" &&
        cucumbersAfterEast[iNext][j] === "."
      ) {
        nextCucumbers[i][j] = "."
        nextCucumbers[iNext][j] = "v"
      }
    }
  }

  // console.log(
  //   nextCucumbers
  //     .map(line => line.join(""))
  //     .join("\n") + "\n"
  // )

  if (
    cucumbers.flat().join("") ===
    nextCucumbers.flat().join("")
  ) {
    console.log(step)
    break
  } else {
    cucumbers = nextCucumbers
  }
}
