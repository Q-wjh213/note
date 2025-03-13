#show math.equation: it => {
  show regex("\p{script=Han}"): set text(font: "Microsoft YaHei")
  it
}
#let quote(body) = {
  // 设置块级元素间距
  set block(spacing: 0.5em)
  
  // 主容器样式
  box(
    width: 100%,
    inset: (
      left: 1.2em,    // 左侧缩进
      top: 0.6em,     // 上内间距
      bottom: 0.6em   // 下内间距
    ),
    fill: rgb("#dfeefa"),  // 浅灰背景
    radius: 4pt,       // 圆角半径
    stroke: (
      left: 4pt + aqua.darken(20%)  // 仅保留左侧装饰线
    ),
    
    // 内容容器增加垂直间距
    pad(0.2em)[
      #set text(fill: rgb("#002953"))  // 新增文字颜色设置
      #body
    ]
  )
}
#let quote2(body) = {
  // 设置块级元素间距
  set block(spacing: 0.5em)
  
  // 主容器样式
  box(
    width: 100%,
    inset: (
      left: 1.2em,    // 左侧缩进
      top: 0.6em,     // 上内间距
      bottom: 0.6em   // 下内间距
    ),
    fill: rgb("#d09af4"),  // 浅灰背景
    radius: 4pt,       // 圆角半径
    stroke: (
      left: 4pt + rgb("#683d7a")  // 仅保留左侧装饰线
    ),
    
    // 内容容器增加垂直间距
    pad(0.2em)[
      #set text(fill: rgb("#41284f"))  // 新增文字颜色设置
      #body
    ]
  )
}

#let breakline=box(place(dy: 1pt, dx: 0pt, line(length: 100%, stroke: .6pt+gray)))