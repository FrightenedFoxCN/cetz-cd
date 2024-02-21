#import "arrows.typ": *

#let to-table(str) = {
    str.split("\\")
       .map(s => s.trim(" ").split("&"))
}

#let is-direction(str) = {
    resolve-arrow-string(str) != none
}

#let possible-styles = (
    "->",               // ordinary arrow
    "=>",               // double line 
    "-",                // single line with no head 
    "=",                // double line with no head
    "-->",              // single line dashed 
    "==>",              // double line dashed
    "--",               // single line dashed with no head
    "==",               // double line dashed with no head
)

#let parse-arrow-info(str) = {
    let args = str.split(",").map(a => a.trim())

    let direction-arg = args.find(is-direction)
    if direction-arg == none {
        panic("Direction string not found!")
    }

    let style-arg = args.find(a => a in possible-styles)
    let style = "->"
    if style-arg != none {
        style = style-arg
    }

    let text-arg = args.find(a => a.starts-with("$"))
    let text = []
    if text-arg != none {
        // completeness test
        if not text-arg.ends-with("$") {
            panic("Unclosed $ sign detected!")
        }

        text = eval(text-arg)
    }
    
    let swapped = "swapped" in args

    let bent-arg = args.find(a => a.starts-with("bent:"))
    let bent = 0
    if bent-arg != none {
        bent = eval(bent-arg.split(":").last())
    }

    let offset-arg = args.find(a => a.starts-with("offset:"))
    let offset = 0
    if offset-arg != none {
        offset = eval(offset-arg.split(":").last())
    }

    return arr(
        direction-arg,
        style: style,
        text: text,
        swapped: swapped,
        bent: bent,
        offset: offset
    )
}

#let parse-item(item) = {
    let math-item = item.matches(regex(`\$(?<mathitem>.*?)\$`.text))
    if math-item != () {
        math-item = eval("$" + math-item.first().captures.first() + "$")
    } else {
        return ("", ())
    }
    
    let arrows = ()

    let arrow-info = item.matches(regex(`ar\[(?<arrowinfo>.*?)\]`.text))
    if arrow-info != () {
        for arrow in arrow-info {
            arrows.push(parse-arrow-info(arrow.captures.first()))
        }
    }

    (math-item, arrows)
}

#let parser(str) = {
    let table = to-table(str)
    let table-content = ()
    let table-arrows = ()
    for lines in table {
        let line-content = ()
        let line-arrows = ()
        for item in lines {
            let (content, arrows) = parse-item(item)
            line-content.push(content)
            line-arrows.push(arrows)
        }
        table-content.push(line-content)
        table-arrows.push(line-arrows)
    }
    (table-content, table-arrows)
}