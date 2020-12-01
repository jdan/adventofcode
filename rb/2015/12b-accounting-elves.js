// http://adventofcode.com/day/12

var numbers = [];

var readline = require("readline");
var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

function extract(data) {
    if (Array.isArray(data)) {
        data.forEach(extract);
    } else if (typeof data === "object") {
        // First pass: Skip red's
        for (var key in data) {
            if (data[key] === "red") {
                return;
            }
        }

        // Second pass, do stuff
        for (var key in data) {
            extract(data[key]);
        }
    } else if (typeof data === "number") {
        numbers.push(data);
    }
}

rl.on("line", function(line) {
    var data = JSON.parse(line);

    extract(data);

    console.log(numbers.reduce(function(a, b) {
        return a + b;
    }, 0));
});
