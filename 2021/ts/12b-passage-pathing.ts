import { strings } from "./util"

const graph: { [key: string]: string[] } = {}
strings().forEach(line => {
  const [a, b] = line.split("-")
  graph[a] ||= []
  graph[a].push(b)
  graph[b] ||= []
  graph[b].push(a)
})

const pathsThrough: {
  [key: string]: number
} = { end: 1 }

function traverse(
  node: string,
  visited: { [key: string]: number },
  caveVisitingTwice?: string
) {
  pathsThrough[node] ||= 0
  pathsThrough[node]++

  const newVisited = { ...visited }
  if (node === node.toLowerCase()) {
    newVisited[node] ||= 0
    newVisited[node]++
  }

  // lol this is terrible
  ;(graph[node] || []).forEach(neighbor => {
    if (
      neighbor === neighbor.toLowerCase()
    ) {
      if (newVisited[neighbor] === 1) {
        if (
          !caveVisitingTwice &&
          neighbor !== "start" &&
          neighbor !== "end"
        ) {
          traverse(
            neighbor,
            newVisited,
            neighbor
          )
        } else if (
          caveVisitingTwice === neighbor
        ) {
          traverse(
            neighbor,
            newVisited,
            caveVisitingTwice
          )
        }
      } else if (
        newVisited[neighbor] === 0 ||
        !newVisited[neighbor]
      ) {
        traverse(
          neighbor,
          newVisited,
          caveVisitingTwice
        )
      }
    } else {
      traverse(
        neighbor,
        newVisited,
        caveVisitingTwice
      )
    }
  })
}

traverse("end", {})
console.log(pathsThrough.start)
