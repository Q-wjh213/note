
#import "@preview/shiroa:0.1.2": *

#show: book

#book-meta(
  title: "note",
  language: "zh-cn",
  summary: [
    - #chapter(none)[笔记]
      - #chapter(none)[数学]
          - #chapter("note/数学/容斥原理.typ")[容斥原理]
          - #chapter("note/数学/期望.typ")[期望]
      - #chapter(none)[奇技淫巧]
          - #chapter("note/奇技淫巧/pb_ds.typ")[pb_ds & rope]
    - #chapter(none)[题解]
      - #chapter(none)[容斥原理]
          - #chapter("note/solution/容斥原理/AT_agc038_e.typ")[AT_agc038_e]
      - #chapter(none)[cdq 分治]
          - #chapter("note/solution/cdq分治/画图.typ")[画图]
  ]
)

// re-export page template
#import "/templates/page.typ": project
#let book-page = project



