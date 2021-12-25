import { paragraphs } from "./util"

const [init, rules] = paragraphs()
const replacements: {
  [key: string]: string
} = {}
rules.split("\n").forEach(line => {
  const [a, b] = line.split(" -> ")
  replacements[a] = b
})

let polymer = init
for (let i = 0; i < 10; i++) {
  const insertions = []
  for (
    let j = 0;
    j < polymer.length - 1;
    j++
  ) {
    const pattern = polymer.slice(j, j + 2)
    insertions.push(
      replacements.hasOwnProperty(pattern)
        ? replacements[pattern]
        : ""
    )
  }

  // Apply the insertions
  let result = ""
  for (
    let j = 0;
    j < polymer.length - 1;
    j++
  ) {
    result += polymer[j]
    result += insertions[j]
  }

  result += polymer[polymer.length - 1]
  polymer = result
}

const freq: { [key: string]: number } = {}
polymer.split("").forEach(character => {
  freq[character] ||= 0
  freq[character]++
})

const mostCommon = Math.max(
  ...Object.entries(freq).map(([_, n]) => n)
)

const leastCommon = Math.min(
  ...Object.entries(freq).map(([_, n]) => n)
)

console.log(mostCommon - leastCommon)
