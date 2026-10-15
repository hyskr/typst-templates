# Course Report

中文课程汇报与实验报告模板，基于 grape-suite 4.0.0，采用标题下居中的姓名、学号和中文日期，以及课程名、报告名分列的页眉。

## 新建工程

在模板库根目录安装后，使用 Typst 创建工程：

```sh
sh scripts/install.sh course-report
typst init @local/course-report:0.1.0 ../my-report
cd ../my-report
typst compile main.typ report.pdf
```

新工程包含 `main.typ`、`content.typ`、`references.bib` 和 `figures/`。修改 `main.typ` 中的课程信息，在 `content.typ` 撰写正文。持续编译使用 `typst watch main.typ report.pdf`。

## 使用接口

```typst
#import "@local/course-report:0.1.0": course-report

#show: course-report.with(
  title: [课程汇报题目],
  short-title: [页眉中的简短题目],
  course: [课程名称],
  author: "张三",
  student-id: "20260001",
  abstract: [摘要内容。],
  keywords: ("关键词一", "关键词二"),
)

= 引言

报告正文。
```

| 参数 | 默认值 | 用途 |
| --- | --- | --- |
| `title` | 课程汇报 | 正文标题与 PDF 元数据 |
| `short-title` | 使用 `title` | 右侧页眉题目 |
| `course` | `none` | 左侧页眉课程名称 |
| `author` | `none` | 姓名与 PDF 作者信息，填写字符串 |
| `student-id` | `none` | 学号 |
| `date` | 当天日期 | 显示为“年/月/日”的中文格式，`none` 隐藏 |
| `abstract` | `none` | 摘要内容 |
| `keywords` | `()` | 关键词数组 |
| `show-outline` | `true` | 显示目录 |
| `text-font` | `("Times New Roman", "Songti SC")` | 正文字体 |

其他参数直接传给 grape-suite 的 `exercise.project`。例如，`colors-primary: black` 使用黑色标题与分隔线，`show-footer-line: false` 隐藏页脚横线，`fontsize: 12pt` 调整正文字号。

默认字体适用于 macOS。其他系统可以通过 `text-font` 指定本机字体，例如 `("Times New Roman", "SimSun")` 或 `("Libertinus Serif", "Noto Serif CJK SC")`。

## 组件

模板同时导出以下组件：

- `data-table(columns:, headers:, rows:, font-size:)`：三线表。
- `pseudocode-list`：Lovelace 0.3.1 伪代码组件。
- `fixed(value, digits:)`、`pct(value, digits:)`：数值与百分比格式化。
- `note(title, body)`：带加粗标签的说明段落。

完整使用示例见 `template/content.typ`，包含图表、数学公式、算法编号和文献引用。

## 源码与许可

`lib.typ` 提供课程报告接口，`components.typ` 提供通用组件。`vendor/grape-suite/` 保存排版所需的 grape-suite 源码，保留其 MIT 许可。

上游项目：[grape-suite](https://github.com/piepert/grape-suite)。本版本提供中文日期、居中的作者信息和学号参数；页眉展示课程与报告题目。伪代码组件来自 [Lovelace](https://typst.app/universe/package/lovelace/)，由 Typst 在首次编译时获取。
