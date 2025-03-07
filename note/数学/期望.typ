#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#set text(font:"Source Han Sans CN VF")
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold

= 期望的线性性
$ EE(a X + b Y)=a EE(X)+ b EE(Y) $

#quote([
  *如何证明这个结论？*

  考虑根据期望的定义，我们有
  $ EE(a X+b Y)&=sum_x sum_y (a x+b y) times p(X=x,Y=y)\
  &=a sum_x sum_y x times p(X=x,Y=y)+b sum_y sum_x y times p(X=x,Y=y)\
  &=a sum_x x sum_y p(X=x,Y=y)+b sum_y y sum_x  p(X=x,Y=y)\
  &=a sum_x x times p(X=x)+b sum_y y times p(Y=y)\
  &=a EE(X)+b EE(Y) $
])