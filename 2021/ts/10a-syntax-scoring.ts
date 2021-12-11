import { strings } from "./util"

const pairs: { [key: string]: string } = {
  ")": "(",
  "]": "[",
  "}": "{",
  ">": "<",
}
const closes = new Set(Object.keys(pairs))
const opens = new Set(Object.values(pairs))
const pointValues: {
  [key: string]: number
} = {
  ")": 3,
  "]": 57,
  "}": 1197,
  ">": 25137,
}

let score = 0
strings().forEach(line => {
  const stack = []
  for (let i = 0; i < line.length; i++) {
    if (opens.has(line[i])) {
      stack.push(line[i])
    } else if (closes.has(line[i])) {
      if (
        stack[stack.length - 1] ===
        pairs[line[i]]
      ) {
        stack.pop()
      } else {
        score += pointValues[line[i]] || 0
        break
      }
    }
  }
})

console.log(score)
