#import "utils.typ": *

// First Rendering of the placed here, mainly to get all the width & height data for all the labels

// All these are useless due to content type limitation!!!

// get the size for an item. Converted to a binary array for convenience

#let get-item-size(item) = style(styles => {
    (measure(table.at(line-index).at(item-index), styles).width.cm(),
    measure(table.at(line-index).at(item-index), styles).height.cm())
})

// get all the sizes of a whole table

#let get-all-size(table) = {
    let size-table = ()

    for line in table {
        size-table.push(
            line.map(get-item-size)
        )
    }

    size-table
}

// get the should-be center from size table

#let get-center-coord(size-table, x-spacing, y-spacing) = {
    let max-height = find-row-max(size-table, metric: (it => it.last()))
    let max-width = find-col-max(size-table, metric: (it => it.first()))

    let x-interval = max-width.len() - 1
    let y-interval = max-height.len() - 1

    let max-x-coord = total-sum(max-width) + x-spacing * x-interval
    let max-y-coord = total-sum(max-height) + y-spacing * y-interval

    let avg-x-split = max-x-coord / x-interval
    let avg-y-split = max-y-coord / y-interval

    let center-table = ()

    for i in range(max-height.len()) {
        let line-center = ()
        for j in range(max-width.len()) {
            line-center.push((i * avg-x-split, j * avg-y-split))
        }
        center-table.push(line-center)
    }

    center-table
}