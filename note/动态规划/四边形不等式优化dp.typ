#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em, spacing: 1.75em)
#import "@preview/tablem:0.2.0": tablem, three-line-table
#set text(font: "Source Han Sans CN VF")
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold

= 四边形不等式

设 $w(i,j)$ 为一代价函数，其中 $i<=j$ 且 $i,j in ZZ$，则我们称若有下式成立，则该代价函数满足四边形不等式：
$ w(a,c)+w(b,d)<=w(a,d)+w(b,c),text("其中") a<=b<=c<=d text("且") a,b,c,d in ZZ $

该条件可以与以下条件互相转化（后文中的变量均为整数）：

若 $a<b$ 时，有
$ w(a,b)+w(a+1,b+1)<=w(a+1,b)+w(a,b+1) $

则该函数也满足四边形不等式。

#quote([
  *证明：*
  + $ w(a,c)+w(b,d)<=w(a,d)+w(b,c) ==> w(a,b)+w(a+1,b+1)<=w(a+1,b)+w(a,b+1) $

    显然，当 $a=x,b=x+1,c=y,d=y+1$ 时，带入条件式，得
    $ w(x,y)+w(x+1,y+1)<=w(x,y+1)+w(x+1,y) $
    结论成立。
  #set math.equation(numbering: "(1)")
  + $
      w(a,b)+w(a+1,b+1)<=w(a+1,b)+w(a,b+1)\
      ==>w(a,c)+w(b,d)<=w(a,d)+w(b,c)
    $
    不妨设 $ w(a,b)+w(a+1,b+k)<=w(a,b+k)+w(a+1,b) $ 成立，则令 $b <-- b+k$，带入 $(1)$ 条件，有
    $ w(a,b+k)+w(a+1,b+k+1)<=w(a+1,b+k)+w(a,b+k+1) $
    将 $(3)$ 式加上 $(2)$ 式，得
    $ w(a,b)+w(a+1,b+k+1)<=w(a+1,b)+w(a,b+k+1) $
    故若我们若知 $(2)$ 成立，则可以推导出 $k<--k+1$ 时 $(2)$ 也成立，我们又知当 $k=0$ 时 $(2)$ 显然成立，故对于任意自然数 $k$，通过数学归纳法可知，$(2)$ 恒成立。不妨设 $c=b+k$，则有
    $ w(a,b)+w(a+1,c)<=w(a,c)+w(a+1,b),"其中"c>=b $
    类似 $(2)$，设
    $ w(a,b)+w(a+k,c)<=w(a,c)+w(a+k,b) $
    成立，其中 $a+k<b$，令 $a<--a+k$，代入 $(5)$，有 $ w(a+k,b)+w(a+k+1,c)<=w(a+k,c)+w(a+k+1,b) $
    $(6)$ 式加 $(7)$ 式，有
    $ w(a,b)+w(a+k+1,c)<=w(a,c)+w(a+k+1,b) $
    故若 $(6)$ 成立，我们可以推导出 $k<--k+1$ 时 $(6)$ 也成立，我们又知当 $k=0$ 时 $(6)$ 显然成立，故对于自然数 $k，(a+k<=b)$，有 $(6)$ 恒成立。不妨设 $d=a+k,"其中"a<=d<=b<=c$，有
    $ w(a,b)+w(d,c)<=w(a,c)+w(d,b) $
    令 $A<--a,B<--d,C<--b,D<--c$ ，则
    $ w(A,C)+w(B,D)<=w(A,D)+w(B,C) $
    证毕。
  #set math.equation(numbering: none)
])
= 应用
假如现在我们要解决类似以下的动态规划问题：
$ f(i)=min{f(j)+w(j,i)} $
我们称能使 $f(i)$ 取到最小值的 $j$ 为 $f(i)$ 的最优决策点，简记 $p(i)=j$。

则若 $w(i,j)$ 满足四边形不等式，我们可以证明 $p(i)$ 单调递增（非严格）。

#quote([
  *证明：*
  #set math.equation(numbering: "(1)")

  不妨设 $k<j<i<i+1$，若 $p(i)=j$，我们要证明 $p(i+1)>=j$。

  由于 $p(i)=j$，故
  $ f(j)+w(j,i)<=f(k)+w(k,i) $
  ，又由四边形不等式，有
  $ w(k,i)+w(j,i+1)<=w(k,i+1)+w(j,i) $
  移项，有
  $ w(j,i+1)-w(j,i)<=w(k,i+1)-w(k,i) $

  $(11)$ 式加 $(13)$ 式，有
  $ f(j)+w(j,i+1)<=f(k)+w(k,i+1) $

  故 $f(i+1)$ 的最优决策点不可能在 $j$ 之前，即 $p(i+1)>=p(i)$。
  #set math.equation(numbering: none)

])
= 例题
#link("https://www.luogu.com.cn/problem/P1912")[\[NOI2009\] 诗人小G]

#quote[
  *题目大意：*

  有一个长为 $n$ 的序列 $a_i$，要把这个序列从左到右分成若干段，不妨设一段的左右端点分别为 $l,r$，给定两个常数 $L,P$，则每一段的代价为 $|(sum_(i=l)^r a_i)+(r-l)-L|^P$,求让代价最小的划分方案。若代价 $>10^18$ 输出 `Too hard to arrange`。

  $1<=n<=10^5$，$1<=a_i<=30$，$1<=L<=3 times 10^6$，$1<=P<=10$。
]

显然，这道题的 dp 转移方程如下：

$ f_i=min_(j<i){f_j+w(j+1,i)} $

其中

$ w(x,y)=|(sum_(i=x)^y a_i)+(y-x)-L|^P $

显然，该 dp 方程很符合能用四边形不等式优化的形式。那么为了使用四边形不等式优化，我们需要证明代价函数 $w$ 符合四边形不等式。为了方便，我们使用第二个四边形不等式进行证明。

考虑证明

$ w(x,y)+w(x+1,y+1)<=w(x,y+1)+w(x+1,y) $

即证明

$
  |(sum_(i=x)^y a_i)+y-x-L|^P+|(sum_(i=x+1)^(y+1)) a_i+y-x-L|^P<=|(sum_(i=x)^(y+1) a_i)+(y+1)-x-L|^P+|(sum_(i=x+1)^(y) a_i)+y-(x+1)-L|^P
$

我们设 $s=sum_(i=x)^y a_i$，则上式为

$ |s+y-x-L|^P+|s+a_(y+1)-a_x+y-x-L|^P<=|s+a_(y+1)+(y+1)-x-L|^P+|s-a_x+y-(x+1)-L|^P $

令 $S=s+y-x-L$，则又可化为

$ |S|^P+|S+a_(y+1)-a_x|^P<=|S+a_(y+1)+1|^P+|S-a_x-1|^P $

若令 $S'=S+a_(y+1)+1$，显然有 $S'>S$，则有

$ |S|^P+|S'-a_x-1|^P<=|S'|^P+|S-a_x-1|^P $

移项，得

$ |S|^P-|S-a_x-1|^P<=|S'|^P-|S'-a_x-1|^P $

即我们要证明四边形不等式成立，只需要证明上式成立。设 $c=a_x-1(c>=0)$，则我们只需证

$ |S|^P-|S-c|^P<=|S'|^P-|S'-c|^P $

令 $g(u)=|u|^P-|u-c|^P$，只需要证明 $g(u)$ 单调递增（非严格）即可。我们分情况讨论。

- 当 $P$ 为偶数时

  显然有 $g(u)=u^P-(u-c)^P$，求导，得 $g'(u)=P u^(P-1)-P (u-c)^(P-1)=P(u^(P-1)-(u-c)^(P-1))$。

  令 $h(u)=u^(P-1)$，显然 $h(u)$ 单调递增（非严格），则 $g'(u)>=0$，$g(u)$ 单调递增（非严格）。

- 当 $P$ 为奇数时

  - 若 $u<=0$

    则 $g(u)=(-u)^P-(c-u)^P$，求导，得
    $ g'(u)=-P u^(P-1)+P(c-u)^(P-1)=-P(u^(P-1)-(u-c)^(P-1)) $
    显然 $|u-c|>|u|$，由于 $P-1$ 为偶数，故 $u^(P-1)-(u-c)^(P-1)<=0$，即 $g'(u)>=0$。故 $g(u)$ 单调递增（非严格）。

  - 若 $0<u<=c$

    则 $g(u)=u^P-(c-u)^P$，求导，得
    $ g'(u)=P u^(P-1)+P(c-u)^(P-1)=P(u^(P-1)+(c-u)^(P-1)) $
    由于 $P>0,u^(P-1)>0,(c-u)^(P-1)>=0$，故 $g'(u)>=0$，$g(u)$ 单调递增。

  - 若 $u>c$

    则 $g(u)=u^P-(u-c)^P$，求导，得

    $ g'(u)=P u^(P-1)-P(u-c)^(P-1)=P(u^(P-1)-(u-c)^(P-1)) $

    由于 $u>c$，则 $u>u-c$，故 $u^(P-1)-(u-c)^(P-1)>0$，$g'(u)>0$，$g(u)$ 单调递增。

    $qed$




