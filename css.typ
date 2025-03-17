#import "@preview/cetz:0.3.2"
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

#let draw(e,x1,y1,x2,y2,points,lines)=cetz.canvas(length: e,{
  import cetz.draw: *
  grid((x1,y1), (int(x2)-.2, int(y2)-.2), step: 1, stroke: gray + 0.2pt)
  line((x1,0), (x2, 0), mark: (end: "stealth"))
  content((), $ x $, anchor: "west")
  line((0, y1), (0, y2), mark: (end: "stealth"))
  content((), $ y $, anchor: "south")
  for x in range(x1,x2) {
    if(x==0){
      continue;
    }
    line((x, 3pt), (x, -3pt))
    content((), anchor: "north", [$#x$]);
  }
  for y in range(y1,y2) {
    if(y==0){
      continue;
    }
    line((3pt,y), (-3pt,y))
    content((), anchor: "east", [$#y$])
  }


  for i in points{
    circle(i,radius:0.06,fill:black)
  }
  for i in lines{
    line(i.at(0),i.at(1))
  }
})
