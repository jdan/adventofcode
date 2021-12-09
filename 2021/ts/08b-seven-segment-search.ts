import {
  intersection,
  strings,
} from "./util";

/**
 *    aaaa
 *   b    c
 *   b    c
 *    dddd
 *   e    f
 *   e    f
 *    gggg
 */

let result = 0;
strings().forEach((line) => {
  const [measured, output] = line
    .split(" | ")
    .map((half) => half.split(" "));

  const candidates: {
    [key: string]: Set<string>;
  } = {
    a: new Set("abcdefg".split("")),
    b: new Set("abcdefg".split("")),
    c: new Set("abcdefg".split("")),
    d: new Set("abcdefg".split("")),
    e: new Set("abcdefg".split("")),
    f: new Set("abcdefg".split("")),
    g: new Set("abcdefg".split("")),
  };

  function restrict(
    given: string,
    known: string
  ) {
    const givenChars = new Set(
      given.split("")
    );
    "abcdefg"
      .split("")
      .forEach((character) => {
        if (givenChars.has(character)) {
          candidates[character] =
            intersection(
              candidates[character],
              new Set(known.split(""))
            );
        } else {
          known
            .split("")
            .forEach((knownChar) => {
              candidates[character].delete(
                knownChar
              );
            });
        }
      });
  }

  measured.forEach((observation) => {
    if (observation.length === 2) {
      restrict(observation, "cf");
    } else if (observation.length === 3) {
      restrict(observation, "acf");
    } else if (observation.length === 4) {
      restrict(observation, "bcdf");
    }

    // if length === 6, it's a 6, 9, or 0
    // if length === 5, it's a 2, 3, or 5
  });

  console.log(candidates);
});
