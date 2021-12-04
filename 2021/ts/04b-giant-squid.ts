import { paragraphs } from "./util";

const input = paragraphs();
const numbers = input[0]
  .split(",")
  .map((s) => parseInt(s));

const boards = input.slice(1).map((str) => {
  return str.split("\n").map((line) =>
    line
      .trim()
      .split(/\s+/)
      .map((s) => {
        return parseInt(s);
      })
  );
});

function enterNumber(
  board: number[][],
  number: number
) {
  for (let i = 0; i < board.length; i++) {
    for (
      let j = 0;
      j < board[i].length;
      j++
    ) {
      if (board[i][j] === number) {
        board[i][j] = 0;

        return (
          board[i].every(
            (square) => square === 0
          ) ||
          board.every((row) => row[j] === 0)
        );
      }
    }
  }

  return false;
}

const winningBoards: Set<number> = new Set(
  []
);

outer: for (
  let i = 0;
  i < numbers.length;
  i++
) {
  const called = numbers[i];

  for (let j = 0; j < boards.length; j++) {
    if (winningBoards.has(j)) {
      continue;
    }

    const board = boards[j];

    if (enterNumber(board, called)) {
      winningBoards.add(j);

      if (
        winningBoards.size === boards.length
      ) {
        console.log(
          called *
            board
              .reduce(
                (flattened, row) =>
                  flattened.concat(row),
                []
              )
              .reduce((sum, i) => sum + i, 0)
        );
        break outer;
      }
    }
  }
}
