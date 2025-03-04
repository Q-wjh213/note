#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#set text(font:"Microsoft YaHei",lang:"zh")
#import "@preview/tablem:0.2.0": tablem, three-line-table

= 整体二分

在遇到某些单个询问可以用二分解决的问题时，面对多组询问，我们思考如果能够对所有询问一并二分解决的话就可以解决整个问题。这时候，整体二分便会成为我们有力的工具。

整体二分是一种离线思想，通过将多组询问同时处理以达到很好的时间复杂度，下面我们以下面几个例子来学习。

== 全序列第 $k$ 大

#quote([
  有一个长为 $n$ 的序列 $a$，现在有 $q$ 组询问，每组询问整个序列中第 $k_i$ 大的值是多少。
  
  $1 <= n,q,k_i <= 10^5$，$0 <= a_i <= 10^9$，$a_i,n,q,k_i in ZZ$。
])

如果直接排序的话，这道题显然是简单的，那我们思考我们能否使用二分的方式解决单个询问呢?

考虑二分答案，已知 $0 <= a_i <=10^9$，说明答案肯定也在 $[0,10^9]$ 之内。不妨二分 $text("mid")$，统计整个序列中小于等于 $text("mid")$ 的数的个数，若其大于等于 $k_i$，说明最终答案一定小于等于 $text("mid")$，则 $r<--text("mid")$，否则 $l<--text("mid")+1$。若 $l=r$，则说明答案为 $l$。

那么我们如果能同时处理所有询问就好了，不难发现，在第一次求 $text("mid")$ 时，我们可以同时处理出所有询问答案和 $text("mid")$ 的关系。那么我们可以把询问分为两类：$text("ans")>text("mid")$ 和 $text("ans")<=text("mid")$。若对两类继续如此递归，复杂度肯定会爆炸。不过我们发现，在二分询问的过程中，我们同样也可以二分 $a_i$。
\ 

- 若 $text("ans") <= text("mid")$，则我们只需要在 $a_i<=text("mid")$ 的数中统计即可，因为在下一次二分中的数一定小于 $text("mid")$，显然 $a_i>text("mid")$ 的 $a_i$ 不可能被统计入答案。

- 若 $text("ans")>text("mid")$，设 $x$ 表示 $a_i<=text("mid")$ 的 $a_i$ 的数量。则我们知道下一次统计当中在这一次被统计进入的数下一次一定还会被统计，所以不妨令 $k_i<--k_i-x$，这时候我们只需要在 $a_i>text("mid")$ 中的 $a_i$ 继续递归即可。

通过这样的做法，$a_i$ 也被不停的二分到不同的区间内，且最多被分到 $log V$ 个区间内，其中 $V$ 是值域。而 $a_i$ 在每个区间内只会被统计到一次，那么总统计次数就是 $n log V$ 的。这样我们就在 $cal(O)(n log V)$ 的时间复杂度内解决了这个问题。