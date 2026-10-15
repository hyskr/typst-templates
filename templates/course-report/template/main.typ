#import "@local/course-report:0.1.0": course-report, data-table, pseudocode-list

#show: course-report.with(
  title: [课程汇报模板示例],
  short-title: [课程汇报],
  course: [课程名称],
  author: "张三",
  student-id: "20260001",
  abstract: [
    本文档展示课程汇报模板的标题、作者信息、目录、正文层级、数学公式、
    图表、伪代码和参考文献。新建工程后，填写本页的课程信息，并在
    content.typ 中撰写报告正文。
  ],
  keywords: ("课程汇报", "实验报告", "Typst"),
)

#include "content.typ"

#bibliography("references.bib", style: "ieee", title: [参考文献])
