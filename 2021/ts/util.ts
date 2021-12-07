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
