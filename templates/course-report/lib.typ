#import "vendor/grape-suite/exercise.typ" as exercise
#import "components.typ": data-table, fixed, pct, note, pseudocode-list

#let course-report(
  title: [课程汇报],
  short-title: none,
  course: none,
  author: none,
  student-id: none,
  date: datetime.today(),
  abstract: none,
  keywords: (),
  show-outline: true,
  text-font: ("Times New Roman", "Songti SC"),
  ..options,
  body,
) = {
  set text(lang: "zh")
  set document(
    title: title,
    author: if author == none { () } else { author },
    date: date,
    keywords: keywords,
  )

  exercise.project(
    type: [课程报告],
    title: title,
    document-title: if short-title == none { title } else { short-title },
    seminar: course,
    author: author,
    student-id: student-id,
    date: date,
    show-outline: show-outline,
    text-font: text-font,
    abstract: if abstract != none or keywords.len() > 0 [
      #if abstract != none [*摘要：* #abstract]
      #if abstract != none and keywords.len() > 0 { parbreak() }
      #if keywords.len() > 0 [*关键词：* #keywords.join("；")]
    ],
    ..options,
    body,
  )
}
