#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#import "@preview/tablem:0.2.0": tablem, three-line-table
#set text(font:"Source Han Sans CN VF")
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold
#import "@preview/cetz:0.3.4"

= wqs 二分

wqs 二分通常用于解决带限制，且 `dp` 值存在凸性的问题，下面我们以一道例题来研究。

= 例题

#quote[
  有 $n$ 个正整数，第 $i$ 个正整数为 $a_i$。现在要求你在其中选出一段长为 $K$ 的子序列，保证 $K mod 2 = 0,K<=n$。设子序列为 ${b_i}$，则规定子序列权值 $w=sum_(i=1)^(K)(-1)^(i+1) b_i$。你需要找到能使 $w$ 最大的子序列。

  $2<=k<=n<=10^5$，$k mod 2=0$。
]

考虑 dp，设 $f_(i,j)$ 表示当前枚举到第 $i$ 位，已经选了 $j$ 个数。转移显然。

不过这样做的时间复杂度是 $cal(O)(n k)$ 的，希望能够优化。

不妨假设 $g_i$ 表示当 $K=2i$ 时题目的答案，则我们可以发现一个规律：

$ (g_(i+1)-g_i)arrow.br $

感性理解，若 $g_(i+2)-g_(i+1)>g_(i+1)-g_i$，不妨将 $g_(i+2)$ 多选的数与 $g_(i+1)$ 中较劣的部分交换，答案显然更优。

这有什么用呢？

我们不妨把 $i$ 放在横坐标上，$g_i$ 放在纵坐标上，则可大致做出此图。

#cetz.canvas(length: 1cm,{
  import cetz.draw: *
  grid((0,0), (9.8, 9.8), step: 1, stroke: gray + 0.2pt)
  line((0, 0), (10, 0), mark: (end: "stealth"))
  content((), $ x $, anchor: "west")
  line((0, 0), (0, 10), mark: (end: "stealth"))
  content((), $ y $, anchor: "south")
  for (x, ct) in ((0, $ 0 $), (2, $ 2 $), (4, $ 4 $), (6, $ 6 $), (8, $ 8 $)) {
    line((x, 3pt), (x, -3pt))
    content((), anchor: "north", ct)
  }
  for (y, ct) in ((2, $ 2 $), (4, $ 4 $), (6, $ 6 $), (8, $ 8 $)) {
    line((3pt,y), (-3pt,y))
    content((), anchor: "east", ct)
  }
  let points=((0,0),(1,3),(2,5),(3,6),(4,6.7),(5,6.2),(6,5),(7,3),(8,0))

  for i in range(0,points.len()-1){
    line(points.at(i),points.at(i+1))
  }
  for i in points{
    circle(i,radius:0.06,fill:black)
  }
})
发现其实际为一个凸包，但是这似乎没有什么用，我们难以求出凸包中的每一个点。

不过我们可以发现一件事情：若我们使用一条直线来切这个凸包上的点，那么截到的点会越来越靠右，如下图所示：

#cetz.canvas(length: 1cm,{
  import cetz.draw: *
  grid((0,0), (9.8, 9.8), step: 1, stroke: gray + 0.2pt)
  line((0, 0), (10, 0), mark: (end: "stealth"))
  content((), $ x $, anchor: "west")
  line((0, 0), (0, 10), mark: (end: "stealth"))
  content((), $ y $, anchor: "south")
  for (x, ct) in ((0, $ 0 $), (2, $ 2 $), (4, $ 4 $), (6, $ 6 $), (8, $ 8 $)) {
    line((x, 3pt), (x, -3pt))
    content((), anchor: "north", ct)
  }
  for (y, ct) in ((2, $ 2 $), (4, $ 4 $), (6, $ 6 $), (8, $ 8 $)) {
    line((3pt,y), (-3pt,y))
    content((), anchor: "east", ct)
  }
  let points=((0,0),(1,3),(2,5),(3,6),(4,6.7),(5,6.2),(6,5),(7,3),(8,0))

  for i in range(0,points.len()-1){
    line(points.at(i),points.at(i+1))
  }
  for i in points{
    circle(i,radius:0.06,fill:black)
  }
  line((0,0.59),(4,10),stroke:blue);
  line((0,5.3),(10,8.8),stroke:green)
  line((4,9),(8,1),stroke:red)
})

这时候，我们有一个重要观察：

*切凸包上某个点的切线的截距必然比同斜率的过其他点的直线截距大。*

不妨设当前斜率为 $k$，假设它过切点 $(x',y')$，则其直线方程为 $y'-y=k(x'-x)$。化简，得\ $y=k x+y'-k x'$。

设 $b=y'-k x'$，则该函数为 $y=k x+b$,即 $g_x=k x+b$，移项得

$ b=g_x-k x $

我们虽然不知道斜率为 $k$ 时的直线切凸包于 $(x,g_x)$ 的具体坐标，但我们知道一件事：当直线与 $(x,g_x)$ 相切时 $b$ 最大。我们若能求出 $b_max,x$，实际上就求出了 $g_x$。虽然也许 $x$ 此时并不等于 $K/2$，但由于斜率的单调性对应了 $x$ 的单调性，我们只需要二分斜率就能找到 $x=K/2$ 的位置。

假如我们现在已经二分出了一个斜率 $k$，那么如何求 $b_max$ 呢？

把原题带入，发现题目转化为，我们希望找到一段长度为偶数的子序列，设其长为 $K$，使得\ $(sum_(i=1)^K (-1)^(i+1)b_i)-k K$ 最大。

注意到此时我们并没有硬性要求要选 $K$ 个，而只是要求任意找一段子序列使结果最大。这显然就不再需要统计我们当前已经选了多少组，而只需要简单的 dp 就能求出结果，时间复杂度 $cal(O)(n)$。在动态规划的过程中，实际上我们也可以统计出 $b$ 最大时的 $x$ 是多少，根据 $x$ 与原题目 $K$ 的大小关系进行二分，就可以求出最终的答案。

二分复杂度 $cal(O)(log n)$，总复杂度 $cal(O)(n log n)$。