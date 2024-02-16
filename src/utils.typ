// some functions for basic utilities
#let make-cetz-block(content) = align(center)[#cetz.canvas(length: 1cm, content)]

#let summing-series(arr, end) = {
    let res = 0

    for i in range(end) {
        res += arr.at(i)
    }

    res
}

#let total-sum(arr) = {
    let res = 0

    for i in arr {
        res += i
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

#let averaging-series(arr) = {
    let length = arr.len()

    if length == 1 {
        return (0, 0)
    }

    let spacing = arr.at(length - 1) / (length - 1)

    for item in arr.enumerate() {
        arr.at(item.first()) = item.first() * spacing
    }

    arr
}

#let center-point(start, end) = {
    ((start.at(0) + end.at(0)) / 2, (start.at(1) + end.at(1)) / 2)
}

#let normalize2d(vec) = {
    let length = calc.sqrt(vec.at(0) * vec.at(0) + vec.at(1) * vec.at(1))
    (vec.at(0) / length, vec.at(1) / length)
}

#let add2d(x, y) = {
    (x.at(0) + y.at(0), x.at(1) + y.at(1))
}

#let scale2d(scalar, vec) = {
    (scalar * vec.at(0), scalar * vec.at(1))
}

#let mult2d(x, y) = {
    (x.at(0) * y.at(0), x.at(1) * y.at(1))
}

#let check-boundary(end_point, bound_x, bound_y) = {
    if (end_point.at(0) < 0 or end_point.at(0) >= bound_x or
        end_point.at(1) < 0 or end_point.at(1) >= bound_y) {
        panic("Item " + repr(end_point) + " out of bound!")
    }
}

// some functions for multi-dimensional array

#let get-pos(arr, (x, y)) = {
    arr.at(y).at(x)
}

#let set-pos(arr, (x, y), val) = {
    arr.at(x).at(y) = val
}

// find the maximum on every row / column and store it in an array
// metric is called for each item and will be used in compare

#let find-row-max(arr, metric: (it => it)) = {
    let row-max = ()

    for line in arr {
        let current-line-max = 0.
        for item in line {
            if metric(item) > current-line-max {
                current-line-max = metric(item)
            }
        }
        row-max.push(current-line-max)
    }

    row-max
}

#let find-col-max(arr, metric: (it => it)) = {
    let col-max = (0., ) * arr.len()

    for line in arr {
        for item in line.enumerate {
            if metric(item.last()) > col-max.at(item.first()) {
                col-max.at(item.first()) = metric(item.last())
            }
        }
    }

    col-max
}