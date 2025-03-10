#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#import "@preview/tablem:0.2.0": tablem, three-line-table
#set text(font:"Source Han Sans CN VF")
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold

= wqs 二分

wqs 二分通常用于解决带限制，且 `dp` 值存在凸性的问题，下面我们以一道例题来研究。

= 例题

#quote[
  有 $n$ 个正整数，第 $i$ 个正整数为 $a_i$。现在要求你在其中选出一段长为 $k$ 的子序列，保证 $k mod 2 = 0,k<=n$。设子序列为 ${b_i}$，则规定子序列权值 $w=sum_(i=1)^(k)(-1)^(i+1) b_i$。你需要找到能使 $w$ 最大的子序列。

  $2<=k<=n<=10^5$，$k mod 2=0$。
]

考虑 `dp`，设 $f_(i,j)$ 表示当前枚举到第 $i$ 位，已经选了 $j$ 个数。转移显然。

不过这样做的时间复杂度是 $cal(O)(n k)$ 的，希望能够优化。

不妨假设 $g_i$ 表示当 $k=2i$ 时题目的答案，则我们可以发现一个规律：

$ (g_(i+1)-g_i)arrow.br $

感性理解，若 $g_(i+2)-g_(i+1)>g_(i+1)-g_i$，不妨将 $g_(i+2)$ 多选的数与 $g_(i+1)$ 中较劣的部分交换，答案显然更优。

这有什么用呢？

我们不妨把 $i$ 放在横坐标上，$g_i$ 放在纵坐标上，则可大致做出此图。

#image("../../image/1.png",width: 80%)

发现其实际为一个凸包，但是这似乎没有什么用，我们难以求出凸包中的每一个点。