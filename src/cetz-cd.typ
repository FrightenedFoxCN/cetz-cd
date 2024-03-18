#import "@preview/cetz:0.1.2"

#import "utils.typ": *
#import "arrows.typ": *
#import "parser.typ": *

#let make-cd(table, arrow, width, height) = style(styles => {align(center)[#cetz.canvas(length: 1cm, {

    // quick check on whether all line has same number of items
    let line-number = table.len()
    let line-length = table.at(0).len()
    
    // for line in table {
    //     if line.len() != line-length {
    //         panic("Numbers of items in a line is different. Check your input!")
    //     }
    // }

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
    
    let coord_x = averaging-series(partial-sum-series(vspacing).enumerate().map(a => a.first() * width + a.last()))
    let coord_y = averaging-series(partial-sum-series(hspacing).enumerate().map(a => - a.first() * height - a.last()))
    
    // finally, place the item into the table
    for line in table.enumerate() {
        for item in line.last().enumerate() {
            cetz.draw.content(
                (coord_x.at(item.first()), coord_y.at(line.first())),
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
                if arrow.direction == (0, 0) {
                    continue
                }

                let line-index = line.first()
                let item-index = item.first()

                let departure-point = (item-index, line-index)
                let end-point = departure-point.zip(arrow.direction).map(((a, b)) => a + b)

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
                    (depart-width-c + 0.1) 
                    * arrow.direction.at(0),
                    coord_y.at(line-index) - 
                    (depart-height-c + 0.2) 
                    * arrow.direction.at(1)
                )
                let line-end = (
                    coord_x.at(end-point.at(0)) -
                    (end-width-c + 0.1) 
                    * arrow.direction.at(0),
                    coord_y.at(end-point.at(1)) + 
                    (end-height-c + 0.1) 
                    * arrow.direction.at(1))
                
                let text-size = (measure(arrow.text, styles).width.cm(), measure(arrow.text, styles).height.cm())

                let arrow-to-draw = cd-arrow(
                    line-start, 
                    line-end,
                    arrow.style,
                    arrow.text, 
                    text-size,
                    arrow.swapped,
                    arrow.bent,
                    arrow.offset
                )
                
                draw-arrow(arrow-to-draw)
            }
        }
    }
})]})

#let cetz-cd(content, width: 2, height: 2) = {
    let (table, arrows) = parser(content.text)
    make-cd(table, arrows, width, height)
}