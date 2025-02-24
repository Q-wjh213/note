#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#set text(font:"Microsoft YaHei",lang:"zh")
#import "@preview/tablem:0.2.0": tablem, three-line-table

= pb_ds&rope: C++ 中强大的扩展库

pb_ds 中内封装了多种强大的数据结构，虽然效率可能并不算很高，但是若在有些时候知道怎么用或许可以解燃眉之急。

= 导入

pb_ds&rope 存在万能头，只需要使用 ```cpp  #include <bits/extc++.h>``` 即可。

pb_ds 中的内容处于命名空间 `__gnu_pbds` 内。

= 哈希表
在 pb_ds 中，封装了 hash_table。这种哈希表相较于 unordered_map 速度更加快，效率更高，更难被卡。

通常在 pb_ds 中常用的哈希表为 gp_hash_table,我们可以通过以下代码创建：
```cpp
// 以下 T1,T2 代表两种类型。
#include<bits/stdc++.h>
__gnu_pbds::gp_hash_table <T1, T2> H1;
```
不难发现其构建方式类似于 `map` 和 `unordered_map`。

#quote()[
  + 相比于 `unordered_map`，其速度更快。
  + 空间复杂度略大于 `unordered_map`。
]

todo：自定义哈希函数

= 堆

在 STL 中的 `priority_queue` 是我们通常在算法竞赛中常用的一种堆，而在 pb_ds 中，同样提供了 `priority_queue`,存储在了 `__gun_pbds` 命名空间内。其与 STL 中的堆的最大区别是其支持如合并等高级操作。

我们可以使用以下代码创建一个最基本的堆：

```cpp
__gnu_pbds::priority_queue<int> Q;
```

其在与 STL 中的 `priority_queue` 在参数传递中稍有区别：

```cpp
std::priority_queue<TypeName, Container, Compare> q;
// 使用 Container 作为底层容器，使用 Compare 作为比较类型
__gnu_pbds::priority_queue<T, Compare, Tag, Allocator>
// T为数据类型，Compare 为比较类型，Tag 为堆类型，Allocator 为空间配置器
```

不难发现，相比 STL 中的堆，pb_ds 的堆中不需要传入底层容器。`Allocator` 在 OI 中基本无使用范围。而 `Tag` 便是其与普通堆的最大不同之处。

#quote([
  *`Tag`* 为 `__gun_pbds` 中提供的五种不同的堆，默认为 `pairing_heap_tag`。

  以下为五种类型：
  \
  - `pairing_heap_tag`
  - `binary_heap_tag`
  - `binomial_heap_tag`
  - `rc_binomial_heap_tag`
  - `thin_heap_tag`

  在 OI 当中，几乎只有第一种堆，即配对堆是有用的，所以后文皆以介绍配对堆为主。
])

配对堆的各操作复杂度如下表格所示：
#align(center)[
  #tablem([
|`push`|`pop`|`modify`|`erase`|`join`|
| ---| ----- | ---------- | ------------------------ | ------------------- | 
| $O(1)$  | 最坏 $O(n)$\ 均摊 $O(log(n))$ | 最坏 $O(n)$\ 均摊 $O(log(n))$ | 最坏 $O(n)$\ 均摊 $O(log(n))$ | $O(1)$ |
])
]

其中 `push` & `pop` 是我们较为熟悉的操作，而 `empty`和 `size` 函数同样存在。接下来讲解剩下三个函数：

- `join` 操作，合并两个堆，如 ```cpp Q1.join(Q2)```，当完成操作后，`Q2` 将会与 `Q1` 合并到 `Q1` 上，且 `Q2` 被删除。
- `erase` 操作，将迭代器 `it` 位置删除，如 ```cpp Q.erase(it)```。
- `modify` 操作，将迭代器 `it` 位置上的值更改为 `val`，如 ```cpp Q.modify(it,val)```。

通常情况下，我们所使用的迭代器为 `push` 的返回值。即 `push` 会 `return` 插入元素的迭代器。

= 平衡树

pb_ds 中存在 tree 类型，即平衡树。它能提供比 set 强大的多的功能。

我们可以通过以下代码创建：

```cpp
__gnu_pbds::tree<type,null_type,less<type>,rb_tree_tag,tree_order_statistics_node_update> T;
//其中 type 为类型，其他值不需要更改。
```

#quote([
  *注意：*其并不支持重复元素，若希望插入相同元素，可以使用 `pair`。其中 `first` 为值，`second` 为一个随机数据或者不重复的数据，通过这种方式可以保证插入数据互不相同，在查询时特殊处理即可。
])

其支持以下操作：
- `insert(x)` : 向树中插入一个数 `x`。返回 `std::pair<iterator,bool>`。`first` 为插入的位置的迭代器，`second` 表示插入是否成功。

- `erase(x)`：从树中删除一个元素/迭代器。如果传入变量为元素，则返回是否删除成功。否则则返回删除迭代器后的下一个迭代器位置。

- `order_of_key(x)`：返回严格小于 `x` 的元素个数，即从 $0$ 开始的排名。

- `find_by_order(x)`：返回排名所对应元素的迭代器。（下标从 `0` 开始）

- `lower_bound(x)`：返回第一个不小于 `x` 的元素所对应的迭代器。

- `upper_bound(x)`：返回第一个严格大于 `x` 的元素所对应的迭代器。

- `join(x)`：将 `x` 树并入当前树，`x` 树被清空。

- `split(x,b)`: 分裂原树，元素小于等于 `x` 保留在当前树，否则分裂到 `b` 树。

- `empty()`：返回是否为空。

- `size()`：返回大小。

#quote[
  *注意：*`join` 操作需要保证并入树和原树的值域不相交，即若将 $b$ 并入 $a$，你需要保证 $max(b)<min(a) text("或") max(a)<min(b)$。
]

*参考资料*
 + #link("https://oi-wiki.org/lang/pb-ds/")[OI-wiki pb_ds 相关资料]

 + #link("https://www.luogu.com.cn/article/zi85ltjk")[比STL还STL？——平板电视]

 + #link("https://www.luogu.com.cn/article/tk8rh0c9")[C++ pb_ds 食用教程]

 + #link("https://www.cnblogs.com/Hanghang007/p/17789124.html")[如何优雅地使用 pb_ds
]