#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#set text(font:"Microsoft YaHei",lang:"zh")

= 画图

#quote([
  == 题意
  给定 $n$ 个点，他们连接成了一个环，其中 $i$ 与 $i+1$ 连边，$1$ 与 $n$ 连边，接下来给出 $m$ 条边 $u_i,v_i$，你需要回答在连接完这 $m$ 条边后是否存在一种情况使得在平面上，边两两不交（无交点）。
  == 输入格式
  ```
  n m
  u_i v_i
  ...
  u_m v_m
  ```
  == 输出格式
  `Yes` 或 `No`，表示是否存在情况。

  == 数据范围
  $1 <= n,m <= 10^5$，$1 <= u_i,v_i <= n$。
])

不妨考虑我们如何才能保证边两两不交，发现环内环外在拓扑意义下等价。若只能在环内连边，显然只需要保证连边所对应的区间要么不相交，要么包含。在环外自然与环内类似。所以我们的问题便转化成了：*我们是否能把题目所给定的边分成两组，使得在对应组别内两两不交（这里的相交指的是部分相交，下文同理）*。

这比较类似于种类并查集的运用。我们思考，相交的边肯定不能同时选入一个集合当中，所以不妨我们设节点 $i$ 表示 $i in A$，而设节点 $i+m$ 表示 $i in B$，其中 $A,B$ 是我们要区分出的两个集合。

则若两条边相交，我们可以把他们对应的节点相连到一个连通分量中，表示若该连通分量中的一个条件满足，则剩下的条件必须全部满足。即若边 $i,j$ 有交集，我们可以连以下的两条边 $i <--> j+m,i+m <--> j$ 表示若 $i in A$，则 $j in B$，$i,j$ 交换后同理。

那我们判断能否成立，即是判断我们的选择是否存在冲突，即 $i,i+m$ 是否同时属于一个连通分量中。

不难发现这个关系可以使用并查集维护，如果我们对每条边暴力找与其相交的边，时间复杂度为 $O(n^2)$。