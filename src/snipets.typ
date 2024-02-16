#import "cetz-cd.typ": *

// a grid with downwards and rightwards array
#let grid-rd(table) = {
    let line-number = table.len()
    let line-length = table.at(0).len()

    for line in table {
        if line.len() != line-length {
            panic("Numbers of items in a line is different. Check your input!")
        }
    }

    cetz-cd-raw(
        table,
        ("r, d & " * (line-length - 1)  + "d \\") * (line-number - 1) + ("r &" * (line-length - 1))
    )
}

// a push-out is simply a 2 by 2 grid
#let pushout(a, b, c, d) = grid-rd(((a, b), (c, d)))

// a triangle with rightwards and downwards arrow
#let triangle-rd(a, b, c) = cetz-cd-raw(((a, b), ("", c)), "r, rd & d")