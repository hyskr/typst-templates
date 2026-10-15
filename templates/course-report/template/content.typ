#import "@local/course-report:0.1.0": data-table, pseudocode-list

= 研究背景与目标

课程报告可以按照“背景与目标、方法与实现、实验结果、讨论与结论”组织。
每个章节围绕一个明确的问题展开，图表与公式放在相关说明附近。

本模板采用中文正文，支持英文术语和数学公式。例如，关联规则分析可通过
支持度与置信度描述商品的共现关系，其经典算法包括 Apriori @agrawal1994。

== 报告内容

+ 说明研究问题、输入数据或实验对象。
+ 介绍采用的方法、参数设置与实现步骤。
+ 展示实验结果，解释关键指标及其含义。
+ 总结发现，并说明适用范围与局限。

= 方法与实现

== 数学公式

设数据集为 $D$，其中包含项集 $X$ 的记录数为 $n(X)$，则支持度为

$ "support"(X) = frac(n(X), |D|) $

公式中的符号应在正文中解释。较长的推导可以单独成段，避免将多个含义不同的
指标放进同一个表达式。

== 图表

@workflow 展示一个通用的研究流程。示意图文件位于 `figures/`，可以替换为
实际实验导出的 SVG、PDF 或 PNG 图片。

#figure(
  image("figures/workflow.svg", width: 95%),
  caption: [课程研究流程示意图],
) <workflow>

表格支持自动编号和交叉引用。@result-table 使用三线表列出示例结果，表中数值仅用于
演示排版。

#figure(
  data-table(
    columns: (2fr, 1fr, 1fr),
    headers: ([方法], [指标 A], [指标 B]),
    rows: (
      ([方案一], [0.82], [12.4]),
      ([方案二], [0.87], [10.8]),
      ([方案三], [0.89], [10.1]),
    ),
  ),
  caption: [示例结果表],
) <result-table>

== 算法伪代码

伪代码采用 Lovelace，支持输入输出、行号、数学符号和嵌套循环。@sum-algorithm 展示
一个简单的累加过程。

#figure(
  kind: "algorithm",
  supplement: [算法],
  pseudocode-list(
    numbered-title: [序列求和],
    booktabs: true,
    booktabs-stroke: 0.7pt,
    line-gap: 0.4em,
  )[
    - *输入：* 数值序列 $x_1, dots, x_n$
    - *输出：* 元素之和 $S$
    + $S <- 0$
    + *for* $i <- 1$ *to* $n$ *do*
      + $S <- S + x_i$
    + *end for*
    + *return* $S$
  ],
) <sum-algorithm>

= 结果与讨论

结果部分应把数据与解释联系起来。比较多个方案时，可以说明指标的提升幅度、
运行成本和选择依据。对于无法从现有数据回答的问题，集中写在局限部分。

== 结论

用一至两段文字回答报告开头提出的问题，给出主要发现及其意义。

== 局限

说明数据规模、实验设置或方法假设对结论的影响。
