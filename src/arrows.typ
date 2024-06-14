#import "@preview/cetz:0.1.2"

#import "utils.typ": *

// Here we calculate the array-related information

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
        } else {
            return none
        }
    }

    res
}

// this is the *internal* representation of the arrow

#let cd-arrow(start, // start point
    end,          // end point
    style,        // style of the arrow
    text,         // text attached to the arrow
    text-size,    // size of the text, this should be passed here due to the limitation of content type
    swapped,      // if the text is on the right; on the left default
    bent,         // if the arrow is bent, a degree is given here
    offset) = (   // offset of the arrow from the centerline
    start: start,
    end: end,
    style: style,
    text: text,
    text-size: text-size,
    swapped: swapped,
    bent: bent,
    offset: offset
)

#let default-arrow(start, end) = arrow(start, end, "-", none, (0, 0), false, 0, 0)
#let default-arrow-with-text(start, end, text, text-size) = arrow(start, end, "-", text, text-size, false, 0, 0)

#let draw-arrow(arrow) = {
    cetz.draw.line(arrow.start, arrow.end, mark: (fill: black, end: ">"), stroke: (thickness: 0.5pt))

    // place the text

    if arrow.text != none {
        // for the visualize effect, the text should be a bit nearer to the start point of the arrow
        let text-position = add2d(scale2d(0.55, arrow.start), scale2d(0.45, arrow.end))
        
        // cetz.draw.circle(text-position, radius:.08)

        // slope of the arrow
        let slope = 0.
        let normal = (0., 0.)
        let tangent = (0., 0.)
        if arrow.end.at(0) - arrow.start.at(0) != 0 {
            slope = (arrow.end.at(1) - arrow.start.at(1)) / (arrow.end.at(0) - arrow.start.at(0))
            normal = normalize2d((-slope, 1.))
            tangent = normalize2d((1., slope))
        } else {
            normal = (1., 0.)
            tangent = (0., 1.)
        }
        
        if arrow.swapped != true {
            text-position = add2d(text-position, scale2d(0.2, normal))
            text-position = add2d(text-position, scale2d(0.5, mult2d(normal, arrow.text-size)))
        } else {
            text-position = add2d(text-position, scale2d(-0.2, normal))
            text-position = add2d(text-position, scale2d(-0.5, mult2d(normal, arrow.text-size)))
        }
        
        // cetz.draw.circle(text-position, radius:.05)
        cetz.draw.content(text-position, arrow.text)
    }
}

// for the user, arr is used to create the arrow

#let arr(direction,
    style : "-", // style of the arrow
    text : none,  // text attached to the arrow
    swapped: false,
    bent : 0.,  // if the arrow is bent, a degree is given here
    offset : 0.) = ( // offset of the arrow from the centerline
    direction: resolve-arrow-string(direction),
    style: style,
    text: text,
    swapped: swapped,
    bent: bent,
    offset: offset
)

#let parse-arrow(content) = {
    content.split("\\")
        .map(a => {a.trim(" ")})
        .map(a => a.split("&")
            .map(a => a.trim(" ").split(",")
                .map(a => arr(a.trim(" ")))))
}