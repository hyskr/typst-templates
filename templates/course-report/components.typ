#import "@preview/lovelace:0.3.1": pseudocode-list

#let fixed(value, digits: 2) = {
  let parts = str(calc.round(value, digits: digits)).split(".")
  let fraction = parts.at(1, default: "")
  if digits == 0 {
    parts.first()
  } else {
    parts.first() + "." + fraction + "0" * (digits - fraction.len())
  }
}
#let pct(value, digits: 2) = fixed(value * 100, digits: digits) + "%"

#let note(title, body) = block[
  *#title：* #body
]

#let data-table(columns: (), headers: (), rows: (), font-size: 9pt) = {
  set text(size: font-size)
  set par(leading: 0.45em, first-line-indent: 0pt)
  table(
    columns: columns,
    inset: (x: 6pt, y: 5pt),
    stroke: none,
    align: (x, y) => if x == 0 { left + horizon } else { center + horizon },
    table.hline(stroke: 0.7pt),
    table.header(..headers.map(h => text(weight: "bold", h))),
    table.hline(stroke: 0.4pt),
    ..rows.flatten(),
    table.hline(stroke: 0.7pt),
  )
}
