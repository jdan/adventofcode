import fs from "fs";

export function stdin() {
  return fs.readFileSync(0, "utf-8");
}

export function numberLine() {
  return stdin()
    .split(",")
    .map((n) => parseInt(n));
}

export function strings(): string[] {
  return stdin().split("\n");
}

export function paragraphs() {
  return stdin().split("\n\n");
}

export function numbers() {
  return strings().map((s) => parseInt(s));
}

export function sum(ls: number[]) {
  return ls.reduce((sum, n) => sum + n);
}

export function intersection<T>(
  a: Set<T>,
  b: Set<T>
): Set<T> {
  return new Set(
    [...a].filter((v) => b.has(v))
  );
}

export function permutations<T>(
  arr: T[]
): T[][] {
  if (arr.length === 0) {
    return [[]];
  } else {
    return arr.flatMap((value, idx) => {
      const tail = permutations([
        ...arr.slice(0, idx),
        ...arr.slice(idx + 1),
      ]);
      return tail.map((sub) => [
        value,
        ...sub,
      ]);
    });
  }
}

export function equals<T>(
  a: Set<T>,
  b: Set<T>
): boolean {
  return (
    a.size === b.size &&
    [...a].every((val) => b.has(val))
  );
}
