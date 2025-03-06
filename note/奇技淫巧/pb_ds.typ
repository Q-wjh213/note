#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#import "@preview/tablem:0.2.0": tablem, three-line-table

= `pb_ds&rope`: C++ 中强大的扩展库

pb_ds 中内封装了多种强大的数据结构，虽然效率可能并不算很高，但是若在有些时候知道怎么用或许可以解燃眉之急。

= 导入

`pb_ds&rope` 存在万能头，只需要使用 ```cpp  #include <bits/extc++.h>``` 即可。

`pb_ds` 中的内容处于命名空间 `__gnu_pbds` 内。

= 哈希表
在 `pb_ds` 中，封装了 `hash_table`。这种哈希表相较于 `unordered_map` 速度更加快，效率更高，更难被卡。

通常在 `pb_ds` 中常用的哈希表为 `gp_hash_table`,我们可以通过以下代码创建：
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

= `rope`

`rope` 是一种高级的数据结构，其并不属于 `pb_ds`。故其也不在 `__gnu_pbds` 命名空间内。实际上，它属于 `__gnu_cxx`。

`rope` 可以实现诸多功能，如序列拼接、单点修改，序列截取，指定下标后添加元素、可持久化等功能，在时间紧迫时可以节省大量时间。

我们可以使用以下代码定义 `rope`。

```cpp
__gnu_cxx::rope<type> s;
// type 为元素类型，如若 s 为字符串，则 type 为 char。
```

类似于 `vector`，其是一种动态的数据类型。当然也可以类似 `vector`，在变量名后面打上括号，写明范围，如 ```cpp __gnu_cxx::rope<type> s(1000);```。同时也可以像 `vector` 一样在变量名后接中括号数字定义一个 `rope` 数组，如 ```cpp __gnu_cxx::rope<type> s[1000];```。

`rope` 也支持将静态数组转化为 `rope`，如现在有一个静态数组 `a`，则我们可以用 ```cpp auto s=__gnu_cxx::roe<int>(a)``` 来将 `a` 数组转化为 `rope`。

#quote([
  *注意：*在静态数组的转化中，你需要保证下表为 0 的位置非 0（空），且仅会转化到第一个为空下标的前一个下标。

  形式化的，若 $i!=0 and a_i=0 and 0 in.not {a_j| j in ZZ union [0,i-1]}$，则转化后的 `rope` 包含 $[0,i-1]$。

  该操作时间复杂度 $O(n)$，其中 $n$ 为有效序列长度。速度远快于逐个元素 `push_back`。
])

== *`rope` 的各种操作*

`rope` 有以下几种操作：

- `a.push_back(x)`：在 `a` 的末尾插入元素 `x`；
- `a.insert(p,x)`: 在 `a` 的下标 `p` 前添加元素 `x`（即添加的第一个元素的下标为 `p`）；
- `a.insert(p,s,n)`：将`rope s` 的前 `n` 位插入 `a` 的下标 `p` 处（同上，`n` 可以省略，若省略则代表整个字符串）；
- `a.erase(p,x)`: 从 `a` 的下标 `p` 开始删除 `x` 个元素；
- `a.replace(p,s)`: 从 `a` 的下标 `p` 开始换成字符串 `s`，若 `a` 的位数不够则补足；
- `a.copy(p,n,s)`：从 `a` 的下标 `p` 开始的 `n` 个字符换成 `s`，若位数不够则补足；
- `a.substr(p,x)`：从 `a` 的下标 `p` 开始截取 `x` 个元素；
- `a[x]` 或 `a.at(x)`：访问下标为 `x` 的元素；
- `a.append(s,p,n)`：把 `s` 中从下标 `p` 开始的 `n` 个元素连接到 `a` 的结尾，如没有参数 `n` 则把 `s` 中下标 `p` 后的所有元素连接到 `a` 的结尾，如参数 `p` 也没有则把整个 `s` 连接到 `a` 的结尾；

#quote([
  `rope` 同样和 `string` 一样支持加法运算符，就算 `rope` 的类型不是 `char` 同样支持。
])

其时间复杂度有多种说法，分别单次操作从 $O(log n) ~ O(sqrt(n))$ 不等。

`rope` 的其他函数：`size()`、`empty()`、`begin()`、`end()`、`clear()` 操作与其他容器类似，这里不再赘述。

== *`rope` 的可持久化*

直接将 `rope` 赋值即可。

如当前时间戳为 `t`，则若要继承上一状态，`s[t]=s[t-1]` 即可；若回到之前的状态 `t2`，`s[t]=s[t2]` 即可。复杂度同样为 $O(log n) ~ O (sqrt(n))$。

如在实现 #link("https://www.luogu.com.cn/problem/P1383")[P1383 高级打字机] 时，可直接使用 `rope`，代码如下：

```cpp
#include<bits/stdc++.h>
#include<bits/extc++.h>
using namespace std;
int const MAX=1e5+10;
__gnu_cxx::rope<char> s[MAX];
signed main(){
	ios::sync_with_stdio(false);
	cin.tie(0);
	cout.tie(0);
	int n;
	cin>>n;
	int now=0;
	for(int i=1;i<=n;i++){
		char op;
		cin>>op;
		if(op=='Q'){
			int x;
			cin>>x;
			cout<<s[now][x-1]<<"\n";
		}else if(op=='T'){
			s[now+1]=s[now];
			char x;
			cin>>x;
			s[++now].push_back(x);
		}else{
			int x;
			cin>>x;
			s[now+1]=s[now-x];
			now++;
		}
	}
	return 0;
}
```
显然运用了 `rope` 的代码更加简洁。

== *优缺点*

`rope` 的优点自然是好写好调，方便，可以极大缩短写代码的时间。缺点是其只能在部分场景中运用，而且其常数较大，若数据范围稍大则较难以通过。

= 参考资料
 + #link("https://oi-wiki.org/lang/pb-ds/")[OI-wiki `pb_ds` 相关资料]

 + #link("https://www.luogu.com.cn/article/zi85ltjk")[比STL还STL？——平板电视]

 + #link("https://www.luogu.com.cn/article/tk8rh0c9")[C++ `pb_ds` 食用教程]

 + #link("https://www.cnblogs.com/Hanghang007/p/17789124.html")[如何优雅地使用 `pb_ds`
]

+ #link("https://zhuanlan.zhihu.com/p/675904773")[实用 STL —— `rope` 学习笔记]
