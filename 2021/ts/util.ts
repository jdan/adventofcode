import fs from "fs";

export function strings() {
  return fs
    .readFileSync(0, "utf-8")
    .split("\n");
}

export function numbers() {
  return strings().map((s) => parseInt(s));
}

export function sum(ls: number[]) {
  return ls.reduce((sum, n) => sum + n);
}
