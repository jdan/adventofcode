// http://adventofcode.com/day/10

var readline = require("readline");
var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

function lookAndSayNext(seq) {
    return seq
        .match(/(\d)\1*/g)
        .map(function(part) {
            return part.length + part[0]
        })
        .join("");
}

rl.on("line", function(line) {
    var seq = lookAndSayNext(line);
    for (var i = 1; i < 50; i++) {
        seq = lookAndSayNext(seq);
    }

    console.log(seq.length);
});
