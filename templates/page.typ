// This is important for shiroa to produce a responsive layout
// and multiple targets.
#import "@preview/shiroa:0.1.2": get-page-width, target, is-web-target, is-pdf-target, plain-text, templates
#import templates: *

// Metadata
#let page-width = get-page-width()
#let is-pdf-target = is-pdf-target()
#let is-web-target = is-web-target()

// Theme (Colors)
#let (
  style: theme-style,
  is-dark: is-dark-theme,
  is-light: is-light-theme,
  main-color: main-color,
  dash-color: dash-color,
  code-extra-colors: code-extra-colors,
) = book-theme-from(toml("theme-style.toml"), xml: it => xml(it))

// Fonts
#let main-font = (
  "Charter",
  "Source Han Serif SC",
  // "Source Han Serif TC",
  // shiroa's embedded font
  "Libertinus Serif",
)
#let code-font = (
  "BlexMono Nerd Font Mono",
  // shiroa's embedded font
  "DejaVu Sans Mono",
)

// Sizes
#let main-size = if is-web-target {
  16pt
} else {
  10.5pt
}
#let heading-sizes = (26pt, 24pt, 18pt, 16pt, main-size)
#let list-indent = 0.5em

/// The project function defines how your document looks.
/// It takes your content and some metadata and formats it.
/// Go ahead and customize it to your liking!
#let project(title: "Typst Book", authors: (), kind: "page", body) = {

  // set basic document metadata
  set document(
    author: authors,
    title: title,
  ) if not is-pdf-target

  // set web/pdf page properties
  set page(
    numbering: none,
    number-align: center,
    width: page-width,
  )

  // remove margins for web target
  set page(
    margin: (
      // reserved beautiful top margin
      top: 20pt,
      // reserved for our heading style.
      // If you apply a different heading style, you may remove it.
      left: 20pt,
      // Typst is setting the page's bottom to the baseline of the last line of text. So bad :(.
      bottom: 0.5em,
      // remove rest margins.
      rest: 0pt,
    ),
    height: auto,
  ) if is-web-target

  // Set main text
  set text(
    font: main-font,
    size: main-size,
    fill: main-color,
    lang: "en",
  )

  // Set main spacing
  set enum(
    indent: list-indent * 0.618,
    body-indent: list-indent,
  )
  set list(
    indent: list-indent * 0.618,
    body-indent: list-indent,
  )
  set par(leading: 0.7em)
  set block(spacing: 0.7em * 1.5)

  // Set text, spacing for headings
  // Render a dash to hint headings instead of bolding it as well if it's for web.
  show heading: set text(weight: "regular") if is-web-target
  show heading: it => {
    let it = {
      set text(size: heading-sizes.at(it.level))
      if is-web-target {
        heading-hash(it, hash-color: dash-color)
      }
      it
    }

    block(
      spacing: 0.7em * 1.5 * 1.2,
      below: 0.7em * 1.2,
      it,
    )
  }

  // link setting
  show link: set text(fill: dash-color)

  // math setting
  show math.equation: set text(weight: 400)

 // code block setting
  // show raw: it => {
  //   set text(font: code-font)
  //   if "block" in it.fields() and it.block {
  //     rect(
  //       width: 100%,
  //       inset: (x: 4pt, y: 5pt),
  //       radius: 4pt,
  //       fill: code-extra-colors.bg,
  //       [
  //         #set text(fill: code-extra-colors.fg) if code-extra-colors.fg != none
  //         #set par(justify: false)
  //         // #place(right, text(luma(110), it.lang))
  //         #it
  //       ],
  //     )
  //   } else {
  //     it
  //   }
  // }
  //show raw : set text(font: ("DejaVu Sans Mono", "Noto Sans CJK SC"))



  // show raw: it => {
  //   set text(font: ("DejaVu Sans Mono","Microsoft YaHei"))
  //   if "block" in it.fields() and it.block {
  //     block(  // 直接对自定义block设置分页属性
  //       breakable: true,        // 显式启用分页
  //       width: 100%,
  //       fill: code-extra-colors.bg,        // 背景色
  //       radius: 2pt,            // 圆角
  //       inset: 8pt,             // 内边距
  //       stroke: (left: 2pt + rgb("#b7bbfa")), // 左侧边框
  //       [
  //         #set text(fill: code-extra-colors.fg) if code-extra-colors.fg != none
  //         #set par(justify: false)
  //         // #place(right, text(luma(110), it.lang))
  //         #it
  //       ],

  //     )
  //   } else {
  //     it
  //   }
  // }
  // show raw: it => {
    
  // }

  show math.equation: it => {
    show regex("\p{script=Han}"): set text(font: "KaiTi")
    it
  }
  show raw: it => {
    set text(font: ("Consolas","FangSong"),size: 1.1em)
    if "block" in it.fields() and it.block {
      block(  // 直接对自定义block设置分页属性
        breakable: true,        // 显式启用分页
        width: 100%,
        fill: code-extra-colors.bg,        // 背景色
        radius: 2pt,            // 圆角
        inset: 8pt,             // 内边距
        //stroke: (left: 2pt + rgb("#b7bbfa")), // 左侧边框
        [
          #set text(fill: code-extra-colors.fg) if code-extra-colors.fg != none
          #set par(justify: false)
          #it
          // #place(right, text(luma(110), it.lang))
          // #let lines = it.text.split("\n")
          // #let cnt=0;
          // #for line in lines {
          //   cnt+=1;
          //   stack(dir: ltr,spacing: 0em)[
          //     #box(width: 1.5em)[
          //       #raw(str(cnt))
          //     ]
          //     #raw(line,lang: it.lang)
          //   ]
            
          // }
        ],

      )
    } else {
      it
    }
  }
  // show raw: it => {
    
  // }

  // Main body.
  set par(justify: true)

  body
}

#let part-style = heading
