
#import "@preview/shiroa:0.2.0": *

#show: book

#book-meta(
  title: "note",
  language: "zh-cn",
  summary: [
    - #chapter(none)[笔记]
        - #chapter(none)[Tips]
            //- #chapter("note/Tips/图论.typ")[图论]
            - #chapter("note/Tips/组合计数.typ")[组合计数]
        - #chapter(none)[数学]
            - #chapter("note/数学/容斥原理.typ")[容斥原理]
            - #chapter("note/数学/期望.typ")[期望]
            - #chapter("note/数学/距离.typ")[距离]
        - #chapter(none)[奇技淫巧]
            - #chapter("note/奇技淫巧/pb_ds.typ")[pb_ds & rope]
            - #chapter("note/奇技淫巧/wqs二分.typ")[wqs 二分]
        - #chapter(none)[数据结构]
            - #chapter("note/数据结构/odt.typ")[珂朵莉树]
            - #chapter("note/数据结构/后缀数组.typ")[后缀数组]
        - #chapter(none)[离线]
            - #chapter("note/离线/整体二分.typ")[整体二分]
        - #chapter(none)[动态规划]
            - #chapter("note/动态规划/动态dp.typ")[动态dp]
            - #chapter("note/动态规划/四边形不等式优化dp.typ")[四边形不等式优化dp]
        - #chapter(none)[图论]
            - #chapter("note/图论/传递闭包.typ")[传递闭包]
            - #chapter("note/图论/prufer序列.typ")[Prufer 序列]
        - #chapter(none)[杂项]
            - #chapter("note/杂项/高维前缀和.typ")[高维前缀和]
    - #chapter(none)[题解]
      - #chapter(none)[容斥原理]
          - #chapter("note/solution/容斥原理/AT_agc038_e.typ")[AT_agc038_e]
      - #chapter(none)[cdq 分治]
          - #chapter("note/solution/cdq分治/画图.typ")[画图]
      - #chapter(none)[贪心]
          - #chapter("note/solution/贪心/shop.typ")[shop]
  ]
)

// re-export page template
#import "/templates/page.typ": project
#let book-page = project



