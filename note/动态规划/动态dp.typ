#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#import "@preview/tablem:0.2.0": tablem, three-line-table
#set text(font:"Source Han Sans CN VF")
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold

= 动态 dp

== 前置：广义矩阵乘法

我们现在定义两个广义矩阵相乘：
$ A times B=C
<==> C_(i,j)=xor.big_(k=1)^(n)(A_(i,k)times.circle B_(k,j)) $

若希望其满足矩阵乘法的性质（如结合律以使用快速幂运算），需要 $xor,times.circle$ 运算满足以下性质：

- $xor$ 运算需要满足交换律。
- $times.circle$ 运算需要满足交换律以及结合律。
- 且 $times.circle$ 对 $xor$ 存在分配律，即 $a times.circle (b xor c)=(a times.circle b) xor (a times.circle c)$。

可以证明若满足以上性质，则其满足矩阵乘法的相关性质。

#quote([
  举几个例子：
\
  - 当 $xor$ 为 $+$，$times.circle$ 为 $times$ 时，其就是正常的矩阵乘法。
  - 当 $xor$ 为 $max$ 操作，$times.circle$ 为 $+$ 时，发现这两个操作满足以上性质，故其为广义矩阵乘法。
])