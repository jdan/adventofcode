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
  visited: Set<string>
) {
  pathsThrough[node] ||= 0
  pathsThrough[node]++
  const newVisited = new Set(visited)
  if (node === node.toLowerCase()) {
    newVisited.add(node)
  }

  ;(graph[node] || []).forEach(neighbor => {
    if (!visited.has(neighbor)) {
      traverse(neighbor, newVisited)
    }
  })
}

traverse("end", new Set([]))
console.log(pathsThrough.start)
