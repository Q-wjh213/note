#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#set text(font:"Noto Sans CJK SC",lang:"zh")
= 容斥原理

$ |union.big_(i=1)^n S_i|=sum_(m=1)^n (-1)^(m-1) sum_(a_i<a_(i-1))|sect.big_(i=1)^m S_(a_i)| $

#quote([
  *证明*
  
  考虑对于一个元素 $x$ 在 $m$ 个集合中出现过。\
  - 若 $m=0$，则显然该元素对等式的左右都不产生贡献。
  - 若 $m!=0$，则 $x$ 对等式左边的贡献显然为1，而对等式右边的贡献可用以下式子说明：
    $ &space space sum_(i=1)^m (-1)^(i-1) binom(m,i)\
    &= sum_(i=1)^m -1 times (-1)^i binom(m,i)\
    &= -sum_(i=1)^m  (-1)^i binom(m,i)\
    &= 1-1-sum_(i=1)^m  (-1)^i binom(m,i)\
    &= 1-(-1)^0 times binom(m,0)-sum_(i=1)^m  (-1)^i binom(m,i)\
    &= 1-sum_(i=0)^m  (-1)^i binom(m,i)\ $

    由于在长为 $m$ 的 01 串中，1 的数量为奇数的串的数量与为偶数的串的数量相同。

    #quote2([
      可采用*数学归纳法*。
      - 当 $m=1$ 时，结论显然成立。
      - 当 $m>1$ 时，若 $k=m-1$ 时结论成立，则当 $k=m$ 时，由于第 $m$ 位选择 0/1 的概率相同，所以显然也成立。
    ])
  \
  故 $sum_(i=0)^m  (-1)^i binom(m,i)=0$,即有
  $ text("原式")=1-0=1 $
  即左边贡献等于右边贡献，所以
])
