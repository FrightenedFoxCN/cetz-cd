#import "@preview/cetz:0.1.2"

#let make-cetz-block(content) = align(center)[#cetz.canvas(length: 1cm, content)]

#let parse-string(content) = {
    content.split("\\")
        .map(a => {a.trim(" ")})
        .map(a => a.split("&")
            .map(a => {math.equation(a.trim(" "), block: true)}))
}

#let resolve-arrow-string(string) = {
    let res = (0, 0)

    for i in string {
        if i == "u" {
            res.at(1) -= 1
        } else if i == "d" {
            res.at(1) += 1
        } else if i == "l" {
            res.at(0) -= 1
        } else if i == "r" {
            res.at(0) += 1
        }
    }

    res
}

#let parse-arrow(content) = {
    content.split("\\")
        .map(a => {a.trim(" ")})
        .map(a => a.split("&")
            .map(a => a.trim(" ").split(",")
                .map(a => resolve-arrow-string(a.trim(" ")))))
}

#let summing-series(arr, end) = {
    let res = 0

    for i in range(end) {
        res += arr.at(i)
    }

    res
}

#let partial-sum-series(arr) = {
    let res = (0, ) * arr.len()

    for i in range(arr.len()) {
        res.at(i) = summing-series(arr, i) 
    }

    res
}

#let check-boundary(end_point, bound_x, bound_y) = {
    if (end_point.at(0) < 0 or end_point.at(0) >= bound_x or
        end_point.at(1) < 0 or end_point.at(1) >= bound_y) {
        panic("Item " + repr(end_point) + " out of bound!")
    }
}

#let make-cd(table, arrow, width, height) = style(styles => {align(center)[#cetz.canvas(length: 1cm, {
    // preparations
    // note that you should not expose all things from cetz.draw
    // due to some naming issues, `line` for instance
    cetz.draw.set-style(mark: (fill: black, end: ">"))

    // quick check on whether all line has same number of items
    let line-number = table.len()
    let line-length = table.at(0).len()
    
    for line in table {
        if line.len() != line-length {
            panic("Numbers of items in a line is different. Check your input!")
        }
    }

    // decide how large the "grid" is

    let hspacing = (0, ) * line-number
    let vspacing = (0, ) * line-length

    for line in table.enumerate() {
        for item in line.last().enumerate() {
            vspacing.at(item.first()) = calc.max(
                measure(item.last(), styles).width.cm(),
                vspacing.at(item.first())
            )
            hspacing.at(line.first()) = calc.max(
                measure(item.last(), styles).height.cm(),
                hspacing.at(line.first())
            )
        }
    }

    // then convert the grid space to coordinate, 2cm in between for now
    // @TODO: add custom extra width
    
    let coord_x = partial-sum-series(vspacing).enumerate().map(a => a.first() * width + a.last())
    let coord_y = partial-sum-series(hspacing).enumerate().map(a => - a.first() * height - a.last())

    
    // finally, place the item into the table
    for line in table.enumerate() {
        for item in line.last().enumerate() {
            cetz.draw.content(
                (coord_x.at(item.first()) + vspacing.at(item.first()) / 2, coord_y.at(line.first())),
                item.last(), anchor: "center"
            )
        }
    }

    // next, let's place the arrow
    
    // the arrow is parsed into a three-dimensional array, first denoting the
    // line, second denoting the item. An item has multiple lines departing
    // from it, which is the third level of the array
    for line in arrow.enumerate() {
        for item in line.last().enumerate() {
            for arrow in item.last() {
                if arrow == (0, 0) {
                    continue
                }

                let line-index = line.first()
                let item-index = item.first()

                let departure-point = (item-index, line-index)
                let end-point = departure-point.zip(arrow).map(((a, b)) => a + b)

                // integrity check on boundaries
                check-boundary(end-point, line-length, line-number)

                let depart-x-c = vspacing.at(item-index) / 2
                let depart-y-c = hspacing.at(line-index) / 2

                let end-x-c = vspacing.at(end-point.at(0)) / 2
                let end-y-c = hspacing.at(end-point.at(1)) / 2

                let depart-height-c = measure(table.at(line-index).at(item-index), styles).height.cm() / 2
                let depart-width-c = measure(table.at(line-index).at(item-index), styles).width.cm() / 2

                let end-height-c = measure(table.at(end-point.last()).at(end-point.first()), styles).height.cm() / 2
                let end-width-c = measure(table.at(end-point.last()).at(end-point.first()), styles).width.cm() / 2

                // then we place the arrow a bit away from the departure point to the end point
                // @TODO: custom padding length
                let line-start = (
                    coord_x.at(item-index) + 
                    depart-x-c + 
                    (depart-width-c + 0.1) 
                    * arrow.at(0),
                    coord_y.at(line-index) - 
                    (depart-height-c + 0.2) 
                    * arrow.at(1)
                )
                let line-end = (
                    coord_x.at(end-point.at(0)) + 
                    end-x-c - 
                    (end-width-c + 0.1) 
                    * arrow.at(0),
                    coord_y.at(end-point.at(1)) + 
                    (end-height-c + 0.1) 
                    * arrow.at(1))
                
                cetz.draw.line(line-start, line-end)
            }
        }
    }
})]})

#let cetz-cd(table, arrow, width: 2, height: 2) = make-cd(table, parse-arrow(arrow), width, height)

#cetz-cd(
    (($...$, $C_(n + 1)$, $C_n$, $C_(n - 1)$, $...$), ($...$, $D_(n + 1)$, $D_n$, $D_(n - 1)$, $...$)),
    "r & r, d, ld & r, d, ld & r, d, ld & ld \\ r & r & r & r &")

#cetz-cd((($H_* (A)$, $H_*^A (X)$, $H_* (S_*^A (X \/ S_* (A)))$, $H_* (A)$, $0$), ($H_* (A)$, $H_* (X)$, $H_* (X, A)$, $H_* (A)$, $0$)), "r, d & r, d & r, d & r, d & d \\ r & r & r & r", width: 1.5)