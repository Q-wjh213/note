#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#import "@preview/tablem:0.2.0": tablem, three-line-table
#set text(font:"Source Han Sans CN VF")
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
  + $w(a,c)+w(b,d)<=w(a,d)+w(b,c) ==> w(a,b)+w(a+1,b+1)<=w(a+1,b)+w(a,b+1)$
    显然，当 $a=x,b=x+1,c=y,d=y+1$ 时，带入条件式，得
    $ w(x,y)+w(x+1,y+1)<=w(x,y+1)+w(x+1,y) $
    结论成立。
  #set math.equation(numbering: "(1)")
  + $ w(a,b)+w(a+1,b+1)<=w(a+1,b)+w(a,b+1)\ 
  ==>w(a,c)+w(b,d)<=w(a,d)+w(b,c) $
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
我们称能使 $f(i)$ 取到最小值的 $j$ 为 $f(i)$ 的决策点，简记 $p(i)=j$。

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