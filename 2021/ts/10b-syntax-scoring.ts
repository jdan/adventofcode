import { strings } from "./util"

const opensToCloses: {
  [key: string]: string
} = {
  "(": ")",
  "[": "]",
  "{": "}",
  "<": ">",
}
const closesToOpens: {
  [key: string]: string
} = {
  ")": "(",
  "]": "[",
  "}": "{",
  ">": "<",
}
const opens = new Set(
  Object.keys(opensToCloses)
)
const closes = new Set(
  Object.values(opensToCloses)
)

const pointValues: {
  [key: string]: number
} = {
  ")": 1,
  "]": 2,
  "}": 3,
  ">": 4,
}

let allScores: number[] = []
strings().forEach(line => {
  const stack = []
  for (let i = 0; i < line.length; i++) {
    if (opens.has(line[i])) {
      stack.push(line[i])
    } else if (closes.has(line[i])) {
      if (
        stack[stack.length - 1] ===
        closesToOpens[line[i]]
      ) {
        stack.pop()
      } else {
        // Corrupted line, ignore
        return
      }
    }
  }

  let score = 0
  stack.reverse().forEach(open => {
    score *= 5
    score += pointValues[opensToCloses[open]]
  })
  allScores.push(score)
})

const sorted = allScores.sort(
  (a, b) => b - a
)
console.log(sorted[(sorted.length - 1) / 2])
